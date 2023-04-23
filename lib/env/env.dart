import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_KEY', obfuscate: true)
  static final openAiKey = _Env.openAiKey;
}
