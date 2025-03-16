import 'package:clashbot_flutter/clients/discord_client.dart';
import 'package:clashbot_flutter/clients/mock_discord_client.dart';
import 'package:clashbot_flutter/globals/credentials.dart';
import 'package:oauth2_client/oauth2_helper.dart';

abstract class AppGlobalSettings {
  static const discordBaseUrl = "https://discord.com/";
  static const discordApiBaseUrl = "https://discord.com/api";
  static const discordApiVersion = "/v6";
  static const discordApiOAuth2Path = "/oauth2";
  static const discordApiOAuth2PathAuth = "/authorize";
  static const discordApiOAuth2PathToken = "/token";
  static const APP_DISCORD_OAUTH_RESPONSE_TYPE_SUCCESS = "code";
  static const APP_DISCORD_OAUTH_RESPONSE_TYPE_ERROR = "error";
  static const APP_DISCORD_OAUTH_RESPONSE_TYPE_ERROR_DESC = "error_description";
  static const Iterable<String> APP_DISCORD_OAUTH_SCOPES = [
    "identify",
    "email",
    "guilds"
  ];

  static get authEndpointURL =>
      discordApiBaseUrl + discordApiOAuth2Path + discordApiOAuth2PathAuth;
  static get tokenEndpointURL =>
      discordApiBaseUrl + discordApiOAuth2Path + discordApiOAuth2PathToken;
  static get apiEndpointURL => discordApiBaseUrl + discordApiVersion;

  static const API_DISCORD_GET_CURRENT_USER = "/users/@me";
  static const API_DISCORD_GET_USER = "/users/";
  static const API_DISCORD_GET_CURRENT_USER_GUILDS = "/users/@me/guilds";
  static const CND_DISCORD_AVATAR_URL = "https://cdn.discordapp.com/avatars/";
  static const CND_DISCORD_ICONS_URL = "https://cdn.discordapp.com/icons/";
}

OAuth2Helper setupOauth2Helper() {
  var client = MockDiscordOauth2Client(
    redirectUri: "${Uri.base.origin}/login/index.html",
    customUriScheme: '',
  );
  var oAuth2Helper = OAuth2Helper(
    client,
    grantType: OAuth2Helper.authorizationCode,
    clientId: Credentials.APP_DISCORD_OAUTH_CLIENT_ID,
    scopes: Credentials.SCOPE,
  );
  return oAuth2Helper;
}
