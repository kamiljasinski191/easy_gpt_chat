import 'dart:io';

import 'package:easy_gpt_chat/app/app.dart';
import 'package:easy_gpt_chat/app/core/configure_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  if (Platform.isAndroid) {
    await MobileAds.instance.initialize();
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}
