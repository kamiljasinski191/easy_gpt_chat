import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_gpt_chat/app/core/configure_dependencies.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
