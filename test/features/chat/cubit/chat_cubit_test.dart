import 'package:bloc_test/bloc_test.dart';
import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/domain/models/message_model.dart';
import 'package:easy_gpt_chat/domain/models/user_model.dart';
import 'package:easy_gpt_chat/domain/repositories/auth_repository.dart';
import 'package:easy_gpt_chat/domain/repositories/chat_gpt_repository.dart';
import 'package:easy_gpt_chat/app/features/chat/cubit/chat_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatGptRepository extends Mock implements ChatGptRepository {}

class MockAuthReposiutory extends Mock implements AuthRepository {}

void main() {
  late ChatCubit sut;

  late MockChatGptRepository mockChatGptRepository;
  late MockAuthReposiutory mockAuthReposiutory;

  setUp(
    () {
      mockChatGptRepository = MockChatGptRepository();
      mockAuthReposiutory = MockAuthReposiutory();

      sut = ChatCubit(
        mockChatGptRepository,
        mockAuthReposiutory,
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
    'all data provided',
    () {
      setUp(
        () {
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
          textFieldCleaner: () {},
          currentUser: const UserModel(email: 'email'),
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
