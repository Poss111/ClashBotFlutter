import 'dart:io';

import 'package:clashbot_flutter/core/config/env.dart';

abstract class Credentials {
  // "837629412328734740";
  // static const APP_DISCORD_OAUTH_CLIENT_ID = "839586949748228156";
  static const APP_DISCORD_OAUTH_REDIRECT_URI = "http://localhost:4200/login";
  static const SCOPE = ['identify', 'guilds'];
  static final appUserCredentialsFile = new File("~/.myapp/credentials.json");
}
