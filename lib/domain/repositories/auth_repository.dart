import 'package:easy_gpt_chat/data/loca_data_source/hive_local_data_source.dart';
import 'package:easy_gpt_chat/domain/models/tokens_model.dart';
import 'package:easy_gpt_chat/domain/models/user_model.dart';
import 'package:easy_gpt_chat/main.dart';

class AuthRepository {
  AuthRepository(this.hiveLocalDataSource);

  final HiveLocalDataSource hiveLocalDataSource;

  Future<UserModel> loginAsGuest() async {
    await hiveLocalDataSource.setGuestUser();
    final UserModel guestUser = await userBox.get('guestUser');
    final TokensModel? guestTokens = await userBox.get('guestTokens');
    if (guestTokens == null) {
      await hiveLocalDataSource.setGuestTokens();
      return guestUser;
    } else {
      return guestUser.copyWith(tokens: guestTokens);
    }
  }
}
