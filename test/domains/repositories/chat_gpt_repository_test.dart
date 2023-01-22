import 'dart:math';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:easy_gpt_chat/data/remote_data_source/chat_gpt_remote_data_source.dart';
import 'package:easy_gpt_chat/domains/models/message_model.dart';
import 'package:easy_gpt_chat/domains/repositories/chat_gpt_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:chat_gpt_sdk/src/model/complete_res.dart';
import 'package:chat_gpt_sdk/src/model/usage.dart';
import 'package:chat_gpt_sdk/src/model/choices.dart';

// lib\src\model\usage.dart

class MockChatGptRemoteDataSource extends Mock
    implements ChatGptRemoteDataSource {}

void main() {
  late MockChatGptRemoteDataSource mockChatGptRemoteDataSource;
  late ChatGptRepository sut;

  setUp(
    () {
      mockChatGptRemoteDataSource = MockChatGptRemoteDataSource();
      sut = ChatGptRepository(mockChatGptRemoteDataSource);
      final Usage usage = Usage.fromJson(
        {'prompt_tokens': 69, 'completion_tokens': 69, 'total_tokens': 69},
      );
      final List<Choices> choices = [
        Choices.fromJson(
          {
            'text': 'tText',
            'index': 0,
            'logprobs': null,
            'finish_reason': 'stop'
          },
        )
      ];

      when(
        () => mockChatGptRemoteDataSource.chatStream(
          text: any(named: 'text'),
          token: any(named: 'token'),
        ),
      ).thenAnswer(
        (_) => Stream<dynamic>.fromIterable(
          [
            CompleteRes('tId', 'tObject', 215697, 'tModel', choices, usage),
          ],
        ),
      );
      when(
        () => mockChatGptRemoteDataSource.setToken(
          token: any(named: 'token'),
        ),
      ).thenAnswer(
        (invocation) async => {},
      );
      when(
        () => mockChatGptRemoteDataSource.hasConnection(),
      ).thenAnswer(
        (invocation) async => true,
      );
    },
  );

  test(
    'should return expected stream',
    () {
      Stream<MessageModel> sutMethod() => sut.chatStreamConverted(
            text: 'testText',
            token: 'testToken',
          );
      expect(sutMethod(),
          emitsInOrder([const MessageModel(message: 'tText', sender: 'bot')]));
    },
  );
  test(
    'should call setToken() once',
    () async {
      verifyNever(
        () => mockChatGptRemoteDataSource.setToken(
          token: any(
            named: 'token',
          ),
        ),
      );
      await sut.setToken(
        token: 'tToken',
      );
      verify(
        () => mockChatGptRemoteDataSource.setToken(
          token: any(
            named: 'token',
          ),
        ),
      ).called(1);
    },
  );
  test(
    'should call hasConnection() once',
    () async {
      verifyNever(
        () => mockChatGptRemoteDataSource.hasConnection(),
      );
      await sut.hasConnection();
      verify(
        () => mockChatGptRemoteDataSource.hasConnection(),
      ).called(1);
    },
  );
  test(
    'hasConnection() should return expected value on call',
    () async {
      final result = await sut.hasConnection();
      expect(result, true);
    },
  );
}
