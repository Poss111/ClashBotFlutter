import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/core/config/env.dart';
import 'package:clashbot_flutter/globals/global_settings.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:retry/retry.dart';
import 'discord_service.dart';

class DiscordServiceMockImpl implements DiscordService {
  final baseHost = 'localhost:3001';

  @override
  Future<DiscordUser> fetchCurrentUserDetails() {
    return http
        .get(Uri.http(baseHost,
            "/api/v6" + AppGlobalSettings.API_DISCORD_GET_CURRENT_USER))
        .then((response) {
          if (response.statusCode != 200) {
            throw ApiException(response.statusCode, response.reasonPhrase);
          }
          return response;
        })
        .timeout(const Duration(seconds: 5))
        .then((value) => DiscordUser.fromJson(value.body));
  }

  @override
  Future<List<DiscordGuild>> fetchUserGuilds() {
    return http
        .get(Uri.http(baseHost,
            "/api/v6" + AppGlobalSettings.API_DISCORD_GET_CURRENT_USER_GUILDS))
        .then((response) {
          if (response.statusCode != 200) {
            throw ApiException(response.statusCode, response.reasonPhrase);
          }
          return response;
        })
        .timeout(const Duration(seconds: 5))
        .then((value) => List<DiscordGuild>.from(
            jsonDecode(value.body).map((x) => DiscordGuild.fromMap(x))));
  }

  @override
  Future<DiscordUser> fetchUserDetails(String discordId) {
    return http
        .get(Uri.http(baseHost,
            "/api/v6" + AppGlobalSettings.API_DISCORD_GET_USER + discordId))
        .then((response) {
          if (response.statusCode != 200) {
            throw ApiException(response.statusCode, response.reasonPhrase);
          }
          return response;
        })
        .timeout(const Duration(seconds: 5))
        .then((value) => DiscordUser.fromJson(value.body));
  }

  @override
  Future<void> loginToDiscord() async {
    await Future.any([Future.delayed(const Duration(seconds: 1))]);
  }
}
