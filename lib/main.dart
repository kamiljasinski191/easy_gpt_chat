import 'dart:io';

import 'package:easy_gpt_chat/app/app.dart';
import 'package:easy_gpt_chat/app/core/configure_dependencies.dart';
import 'package:easy_gpt_chat/domain/models/tokens_model.dart';
import 'package:easy_gpt_chat/domain/models/user_model.dart';
import 'package:easy_gpt_chat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';

late Box userBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Hive.registerAdapter<UserModel>(UserModelAdapter());
  Hive.registerAdapter<TokensModel>(TokensModelAdapter());
  await Hive.initFlutter('EasyGPT Chat');
  configureDependencies();
  if (Platform.isAndroid) {
    await MobileAds.instance.initialize();
  }

  userBox = await Hive.openBox('userBox');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const App());
  });
}
