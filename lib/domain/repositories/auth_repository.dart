import 'package:easy_gpt_chat/data/loca_data_source/hive_local_data_source.dart';
import 'package:easy_gpt_chat/data/remote_data_source/auth_remote_data_source.dart';
import 'package:easy_gpt_chat/domain/models/tokens_model.dart';
import 'package:easy_gpt_chat/domain/models/user_model.dart';
import 'package:easy_gpt_chat/main.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@injectable
class AuthRepository {
  AuthRepository(
    this.hiveLocalDataSource,
    this.authRemoteDataSource,
  );

  final HiveLocalDataSource hiveLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;

  Stream<UserModel?> getUserStream() {
    return authRemoteDataSource.currentUserStream();
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) {
    return authRemoteDataSource.registerUser(
      email: email,
      password: password,
    );
  }

  Future<void> logInUser({
    required String email,
    required String password,
  }) {
    return authRemoteDataSource.logInUser(
      email: email,
      password: password,
    );
  }

  Future<void> resetPassword({
    required String email,
  }) {
    return authRemoteDataSource.resetPassword(email: email);
  }

  Future<void> logOutUser() {
    return authRemoteDataSource.logOutUser();
  }

  Future<void> updateUserTokens({
    required int currentTokens,
    required int amount,
  })  {
    return authRemoteDataSource.updateUserTokens(
      data: {
        'tokens': {'free_tokens': currentTokens + amount}
      },
    );
  }

  //GUEST

  Future<UserModel?> getGuestUser() async {
    final UserModel? guestUser = await userBox.get('guestUser');
    return guestUser;
  }

  Future<UserModel> loginAsGuest() async {
    final UserModel? guestUser = await userBox.get('guestUser');
    final TokensModel? guestTokens = await userBox.get('guestTokens');
    if (guestUser == null) {
      if (guestTokens == null) {
        await hiveLocalDataSource.setGuestTokens();
        final TokensModel guestTokens = await userBox.get('guestTokens');
        await hiveLocalDataSource.setGuestUser(tokens: guestTokens);
      } else {
        await hiveLocalDataSource.setGuestUser(tokens: guestTokens);
      }

      final UserModel? guestUser = await userBox.get('guestUser');
      return guestUser!;
    } else {
      return guestUser;
    }
  }

  Future<void> updateGuestUser({required int amount}) async {
    final UserModel? guestUser = await userBox.get('guestUser');
    final TokensModel? guestTokens = await userBox.get('guestTokens');
    final newAmountOfTokens = guestTokens!.freeTokens + amount;
    final newTokens = TokensModel(freeTokens: newAmountOfTokens);
    await userBox.put(
      'guestTokens',
      newTokens,
    );
    await userBox.put(
      'guestUser',
      guestUser!.copyWith(tokens: newTokens),
    );
  }

  Future<void> deleteGuestUser() async {
    await userBox.delete('guestUser');
  }

  Future<bool> hasConnection() async {
    final hasConnection = await InternetConnectionChecker().hasConnection;
    return hasConnection;
  }
}
