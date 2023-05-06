import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/globals/global_settings.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:retry/retry.dart';
import 'discord_service.dart';

class DiscordServiceImpl implements DiscordService {
  OAuth2Helper oAuth2Helper;

  DiscordServiceImpl(this.oAuth2Helper);

  Map<String, String> get baseHeaders {
    return {'Content-Type': 'application/x-www-form-urlencoded'};
  }

  @override
  Future<DiscordUser> fetchCurrentUserDetails() {
    return retry(
        () => oAuth2Helper
                .get(
                    AppGlobalSettings.apiEndpointURL +
                        AppGlobalSettings.API_DISCORD_GET_CURRENT_USER,
                    headers: baseHeaders)
                .then((response) {
              if (response.statusCode != 200) {
                throw ApiException(response.statusCode, response.reasonPhrase);
              }
              return response;
            }).timeout(const Duration(seconds: 5)),
        retryIf: (e) =>
            e is SocketException ||
            e is TimeoutException ||
            (e is ApiException && e.code == HttpStatus.tooManyRequests)).then(
        (value) => DiscordUser.fromJson(value.body));
  }

  @override
  Future<List<DiscordGuild>> fetchUserGuilds() {
    return retry(
        () => oAuth2Helper
                .get(
                    AppGlobalSettings.apiEndpointURL +
                        AppGlobalSettings.API_DISCORD_GET_CURRENT_USER_GUILDS,
                    headers: baseHeaders)
                .then((response) {
              if (response.statusCode != 200) {
                throw ApiException(response.statusCode, response.reasonPhrase);
              }
              return response;
            }).timeout(const Duration(seconds: 5)),
        retryIf: (e) =>
            e is SocketException ||
            e is TimeoutException ||
            (e is ApiException && e.code == HttpStatus.tooManyRequests)).then(
        (value) {
      Iterable l = jsonDecode(value.body);
      return List<DiscordGuild>.from(l.map((model) {
        return DiscordGuild.fromMap(model);
      }));
    });
  }

  @override
  Future<void> loginToDiscord() async {
    await oAuth2Helper.getToken();
  }
  
  @override
  Future<DiscordUser> fetchUserDetails(String discordId) {
    return retry(
        () => oAuth2Helper
                .get(
                    AppGlobalSettings.apiEndpointURL +
                        AppGlobalSettings.API_DISCORD_GET_USER +
                        discordId,
                    headers: baseHeaders)
                .then((response) {
              if (response.statusCode != 200) {
                throw ApiException(response.statusCode, response.reasonPhrase);
              }
              return response;
            }).timeout(const Duration(seconds: 5)),
        retryIf: (e) =>
            e is SocketException ||
            e is TimeoutException ||
            (e is ApiException && e.code == HttpStatus.tooManyRequests)).then(
        (value) => DiscordUser.fromJson(value.body));
  }
}
