import 'package:clash_bot_api/api.dart';

class ClashBotClient {
  late ApiClient _apiClient;
  late UserApi _userApi;
  UserApi get userApi => _userApi;

  ClashBotClient() {
    _apiClient = ApiClient(basePath: "http://localhost:8080");
    _userApi = UserApi(_apiClient);
  }
}