import 'package:oauth2_client/oauth2_client.dart';

class MockDiscordOauth2Client extends OAuth2Client {
  MockDiscordOauth2Client(
      {required String redirectUri, required String customUriScheme})
      : super(
            authorizeUrl:
                'http://localhost:3001/oauth2/authorize', //Your service's authorization url
            tokenUrl:
                'http://localhost:3001/api/oauth2/token', //Your service access token url
            refreshUrl: 'http://localhost:3001/auth/token',
            redirectUri: redirectUri,
            customUriScheme: customUriScheme);
}
