import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(
  environment: true
  obfuscate: true,
)
abstract class Env {
  @EnviedField(varName: 'CLASHBOT_SERVICE_URL')
  static const String clashbotServiceUrl = _Env.clashbotServiceUrl;
}
