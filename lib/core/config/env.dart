import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(
  environment: true,
  // obfuscate: true,
)
abstract class Env {
  @EnviedField(useConstantCase: true, varName: 'CLASHBOT_SERVICE_URL')
  static String clashbotServiceUrl = _Env.clashbotServiceUrl;
  @EnviedField(useConstantCase: true, varName: 'MOCK_DISCORD_SERVICE')
  static String mockDiscordService = _Env.mockDiscordService;
}
