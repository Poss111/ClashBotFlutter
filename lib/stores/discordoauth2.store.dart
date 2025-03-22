import 'dart:convert';

import 'package:clashbot_flutter/clients/discord_client.dart';
import 'package:clashbot_flutter/globals/credentials.dart';
import 'package:clashbot_flutter/globals/global_settings.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:mobx/mobx.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'dart:developer' as developer;

import '../models/discord_guild.dart';

part 'discordoauth2.store.g.dart';

class DiscordOAuth2Store = _DiscordOAuth2Store with _$DiscordOAuth2Store;

abstract class _DiscordOAuth2Store with Store {
  @observable
  DiscordUser currentUser = new DiscordUser('0', 'Not Logged In', 'N/A', '');

  @observable
  List<DiscordGuild> usersGuilds = [];

  @computed
  bool get isLoggedIn => currentUser.id != '0';

  @observable
  late Response lastReceivedResponse;

  @action
  void setLastReceivedResponse(Response response) {
    lastReceivedResponse = response;
  }

  @observable
  OAuth2Helper? oAuth2Helper;

  @action
  void setOAuth2Helper(OAuth2Helper oAuth2Helper) {
    this.oAuth2Helper = oAuth2Helper;
  }

  @observable
  ObservableFuture<DiscordUser> discordUserFuture =
      ObservableFuture.value(new DiscordUser('0', 'Not Logged In', 'N/A', ''));

  @observable
  ObservableFuture<List<DiscordGuild>> discordGuildsFuture =
      ObservableFuture.value([]);

  @computed
  bool get userDetailsReady =>
      discordUserFuture !=
          ObservableFuture.value(
              new DiscordUser('0', 'Not Logged In', 'N/A', '')) &&
      discordUserFuture.status == FutureStatus.fulfilled;

  @action
  Future<DiscordUser> fetchCurrentUserDetails() async {
    final future = oAuth2Helper?.get(
        AppGlobalSettings.apiEndpointURL +
            AppGlobalSettings.API_DISCORD_GET_CURRENT_USER,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }).then((value) => DiscordUser.fromJson(value.body));

    if (future != null) {
      discordUserFuture = ObservableFuture(future);

      return currentUser = await future;
    }
    return ObservableFuture.value(
        new DiscordUser('0', 'Not Logged In', 'N/A', ''));
  }

  @action
  Future<List<DiscordGuild>> fetchUserGuilds() async {
    final future = oAuth2Helper?.get(
        AppGlobalSettings.apiEndpointURL +
            AppGlobalSettings.API_DISCORD_GET_CURRENT_USER_GUILDS,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        }).then((value) {
      Iterable l = jsonDecode(value.body);
      return List<DiscordGuild>.from(l.map((model) {
        return DiscordGuild.fromMap(model);
      }));
    });

    if (future != null) {
      discordGuildsFuture = ObservableFuture(future);
      List<DiscordGuild> guilds = await future;
      setDiscordUserGuilds(guilds);
      return usersGuilds = guilds;
    }
    return ObservableFuture.value([]);
  }

  @observable
  late List<DiscordGuild> discordUserGuilds = [];

  @action
  void setDiscordUserGuilds(List<DiscordGuild> list) {
    discordUserGuilds = list;
  }

  @computed
  Map<String, String> get headers {
    Map<String, String> h = {
      // 'Authorization': 'Bearer ' + oAuth2Helper.accessToken,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    return h;
  }

  @observable
  String userOAuth2ReponseURL = "";

  @action
  void setUserOAuth2ReponseURL(String url) {
    userOAuth2ReponseURL = url;
  }
}
