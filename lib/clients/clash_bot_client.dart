import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/core/config/env.dart';

class ClashBotClient {
  late ApiClient _apiClient;
  late UserApi _userApi;
  UserApi get userApi => _userApi;

  ClashBotClient() {
    _apiClient = ApiClient(basePath: Env.clashbotServiceUrl);
    _userApi = UserApi(_apiClient);
  }
}
