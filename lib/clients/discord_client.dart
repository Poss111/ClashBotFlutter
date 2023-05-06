import 'package:oauth2_client/oauth2_client.dart';

class DiscordOauth2Client extends OAuth2Client {
  DiscordOauth2Client(
      {required String redirectUri, required String customUriScheme})
      : super(
            authorizeUrl:
                'https://discord.com/oauth2/authorize', //Your service's authorization url
            tokenUrl:
                'https://discord.com/api/oauth2/token', //Your service access token url
            refreshUrl: 
                'http://localhost:8084/auth/token',
            redirectUri: redirectUri,
            customUriScheme: customUriScheme);
}
