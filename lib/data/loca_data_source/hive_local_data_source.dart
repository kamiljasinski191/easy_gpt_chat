import 'dart:math';

import 'package:easy_gpt_chat/domain/models/tokens_model.dart';
import 'package:easy_gpt_chat/domain/models/user_model.dart';
import 'package:easy_gpt_chat/main.dart';

class HiveLocalDataSource {
  HiveLocalDataSource();

  final randomId = Random().nextInt(100000).toString();

  Future<void> setGuestUser() async {
    await userBox.put(
      'guestUser',
      UserModel(
        id: randomId,
        email: 'guest',
        tokens: const TokensModel(),
      ),
    );
  }

  Future<void> setGuestTokens() async {
    await userBox.put(
      'guestTokens',
      const TokensModel(),
    );
  }

  Future<void> deleteGuestUser() async {
    await userBox.delete('guestUser');
  }
}
