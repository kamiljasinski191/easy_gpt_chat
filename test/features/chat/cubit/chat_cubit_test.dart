import 'package:bloc_test/bloc_test.dart';
import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/domain/models/message_model.dart';
import 'package:easy_gpt_chat/domain/repositories/chat_gpt_repository.dart';
import 'package:easy_gpt_chat/features/chat/cubit/chat_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatGptRepository extends Mock implements ChatGptRepository {}

void main() {
  late ChatCubit sut;

  late MockChatGptRepository mockChatGptRepository;

  setUp(
    () {
      mockChatGptRepository = MockChatGptRepository();

      sut = ChatCubit(
        mockChatGptRepository,
      );

      when(() => mockChatGptRepository.chatStreamConverted(
            text: any(named: 'text'),
          )).thenAnswer(
        (_) => Stream<MessageModel>.fromIterable(
          [
            const MessageModel(
              message: 'lol1',
              sender: 'bot',
            ),
            const MessageModel(
              message: 'lol2',
              sender: 'user',
            ),
            const MessageModel(
              message: 'lol3',
              sender: 'god',
            ),
          ],
        ),
      );
    },
  );

  test(
    'initial state is ChatState()',
    () {
      expect(
        sut.state,
        const ChatState(),
      );
    },
  );

  group(
    'noInternetConnection',
    () {
      setUp(
        () {
          when(
            () => mockChatGptRepository.hasConnection(),
          ).thenAnswer(
            (_) async => false,
          );
        },
      );
      blocTest<ChatCubit, ChatState>(
        '''emits state error with noInternet message when user 
        have no connection on start app.''',
        build: () => sut,
        act: (bloc) => bloc.start(),
        expect: () => [
          const ChatState(
            status: Status.initial,
          ),
          const ChatState(
            status: Status.loading,
          ),
          const ChatState(
            status: Status.error,
            errorMessage: 'noInternet',
          ),
        ],
      );
      blocTest<ChatCubit, ChatState>(
        '''emits state error with noInternet message when user 
        have no connection on try to send message.''',
        build: () => sut,
        act: (cubit) => cubit.sendMessage(
          message: 'lol4',
          sender: 'user',
        ),
        expect: () => [
          const ChatState(
            status: Status.error,
            errorMessage: 'noInternet',
          ),
        ],
      );
    },
  );

  group(
    'noApiKey',
    () {
      setUp(
        () {
          when(
            () => mockChatGptRepository.hasConnection(),
          ).thenAnswer(
            (_) async => true,
          );
        },
      );
     
    },
  );

  group(
    'all data provided',
    () {
      setUp(
        () {
          when(
            () => mockChatGptRepository.hasConnection(),
          ).thenAnswer(
            (_) async => true,
          );
          when(
            () => mockChatGptRepository.setToken(),
          ).thenAnswer(
            (_) async => {},
          );
        },
      );
      blocTest<ChatCubit, ChatState>(
        '''emits state succes with expected [MessageModel]s when 
        all data provided at start.''',
        build: () => sut,
        act: (bloc) => bloc.start(),
        expect: () => [
          const ChatState(
            status: Status.initial,
          ),
          const ChatState(
            status: Status.loading,
            messages: [],
            errorMessage: '',
          ),
          const ChatState(
            status: Status.succes,
            messages: [],
          ),
        ],
      );
      blocTest<ChatCubit, ChatState>(
        '''emits state succes with expected [MessageModel]s when 
        all data provided at try to send message.''',
        build: () => sut,
        act: (cubit) => cubit.sendMessage(
          message: 'lol4',
          sender: 'user',
        ),
        expect: () => [
          const ChatState(
            status: Status.loading,
            messages: [
              MessageModel(
                message: 'lol3',
                sender: 'god',
              ),
              MessageModel(
                message: 'lol2',
                sender: 'user',
              ),
              MessageModel(
                message: 'lol1',
                sender: 'bot',
              ),
              MessageModel(
                message: 'lol4',
                sender: 'user',
              ),
            ],
            errorMessage: '',
          ),
          const ChatState(
            status: Status.succes,
            messages: [
              MessageModel(
                message: 'lol3',
                sender: 'god',
              ),
              MessageModel(
                message: 'lol2',
                sender: 'user',
              ),
              MessageModel(
                message: 'lol1',
                sender: 'bot',
              ),
              MessageModel(
                message: 'lol4',
                sender: 'user',
              ),
            ],
          ),
        ],
      );
    },
  );
}
