// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discordoauth2.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DiscordOAuth2Store on _DiscordOAuth2Store, Store {
  Computed<bool>? _$isLoggedInComputed;

  @override
  bool get isLoggedIn =>
      (_$isLoggedInComputed ??= Computed<bool>(() => super.isLoggedIn,
              name: '_DiscordOAuth2Store.isLoggedIn'))
          .value;
  Computed<bool>? _$userDetailsReadyComputed;

  @override
  bool get userDetailsReady => (_$userDetailsReadyComputed ??= Computed<bool>(
          () => super.userDetailsReady,
          name: '_DiscordOAuth2Store.userDetailsReady'))
      .value;
  Computed<Map<String, String>>? _$headersComputed;

  @override
  Map<String, String> get headers =>
      (_$headersComputed ??= Computed<Map<String, String>>(() => super.headers,
              name: '_DiscordOAuth2Store.headers'))
          .value;

  late final _$currentUserAtom =
      Atom(name: '_DiscordOAuth2Store.currentUser', context: context);

  @override
  DiscordUser get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(DiscordUser value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$usersGuildsAtom =
      Atom(name: '_DiscordOAuth2Store.usersGuilds', context: context);

  @override
  List<DiscordGuild> get usersGuilds {
    _$usersGuildsAtom.reportRead();
    return super.usersGuilds;
  }

  @override
  set usersGuilds(List<DiscordGuild> value) {
    _$usersGuildsAtom.reportWrite(value, super.usersGuilds, () {
      super.usersGuilds = value;
    });
  }

  late final _$lastReceivedResponseAtom =
      Atom(name: '_DiscordOAuth2Store.lastReceivedResponse', context: context);

  @override
  Response get lastReceivedResponse {
    _$lastReceivedResponseAtom.reportRead();
    return super.lastReceivedResponse;
  }

  bool _lastReceivedResponseIsInitialized = false;

  @override
  set lastReceivedResponse(Response value) {
    _$lastReceivedResponseAtom.reportWrite(value,
        _lastReceivedResponseIsInitialized ? super.lastReceivedResponse : null,
        () {
      super.lastReceivedResponse = value;
      _lastReceivedResponseIsInitialized = true;
    });
  }

  late final _$oAuth2HelperAtom =
      Atom(name: '_DiscordOAuth2Store.oAuth2Helper', context: context);

  @override
  OAuth2Helper? get oAuth2Helper {
    _$oAuth2HelperAtom.reportRead();
    return super.oAuth2Helper;
  }

  @override
  set oAuth2Helper(OAuth2Helper? value) {
    _$oAuth2HelperAtom.reportWrite(value, super.oAuth2Helper, () {
      super.oAuth2Helper = value;
    });
  }

  late final _$discordUserFutureAtom =
      Atom(name: '_DiscordOAuth2Store.discordUserFuture', context: context);

  @override
  ObservableFuture<DiscordUser> get discordUserFuture {
    _$discordUserFutureAtom.reportRead();
    return super.discordUserFuture;
  }

  @override
  set discordUserFuture(ObservableFuture<DiscordUser> value) {
    _$discordUserFutureAtom.reportWrite(value, super.discordUserFuture, () {
      super.discordUserFuture = value;
    });
  }

  late final _$discordGuildsFutureAtom =
      Atom(name: '_DiscordOAuth2Store.discordGuildsFuture', context: context);

  @override
  ObservableFuture<List<DiscordGuild>> get discordGuildsFuture {
    _$discordGuildsFutureAtom.reportRead();
    return super.discordGuildsFuture;
  }

  @override
  set discordGuildsFuture(ObservableFuture<List<DiscordGuild>> value) {
    _$discordGuildsFutureAtom.reportWrite(value, super.discordGuildsFuture, () {
      super.discordGuildsFuture = value;
    });
  }

  late final _$discordUserGuildsAtom =
      Atom(name: '_DiscordOAuth2Store.discordUserGuilds', context: context);

  @override
  List<DiscordGuild> get discordUserGuilds {
    _$discordUserGuildsAtom.reportRead();
    return super.discordUserGuilds;
  }

  bool _discordUserGuildsIsInitialized = false;

  @override
  set discordUserGuilds(List<DiscordGuild> value) {
    _$discordUserGuildsAtom.reportWrite(
        value, _discordUserGuildsIsInitialized ? super.discordUserGuilds : null,
        () {
      super.discordUserGuilds = value;
      _discordUserGuildsIsInitialized = true;
    });
  }

  late final _$userOAuth2ReponseURLAtom =
      Atom(name: '_DiscordOAuth2Store.userOAuth2ReponseURL', context: context);

  @override
  String get userOAuth2ReponseURL {
    _$userOAuth2ReponseURLAtom.reportRead();
    return super.userOAuth2ReponseURL;
  }

  @override
  set userOAuth2ReponseURL(String value) {
    _$userOAuth2ReponseURLAtom.reportWrite(value, super.userOAuth2ReponseURL,
        () {
      super.userOAuth2ReponseURL = value;
    });
  }

  late final _$fetchCurrentUserDetailsAsyncAction = AsyncAction(
      '_DiscordOAuth2Store.fetchCurrentUserDetails',
      context: context);

  @override
  Future<DiscordUser> fetchCurrentUserDetails() {
    return _$fetchCurrentUserDetailsAsyncAction
        .run(() => super.fetchCurrentUserDetails());
  }

  late final _$fetchUserGuildsAsyncAction =
      AsyncAction('_DiscordOAuth2Store.fetchUserGuilds', context: context);

  @override
  Future<List<DiscordGuild>> fetchUserGuilds() {
    return _$fetchUserGuildsAsyncAction.run(() => super.fetchUserGuilds());
  }

  late final _$_DiscordOAuth2StoreActionController =
      ActionController(name: '_DiscordOAuth2Store', context: context);

  @override
  void setLastReceivedResponse(Response response) {
    final _$actionInfo = _$_DiscordOAuth2StoreActionController.startAction(
        name: '_DiscordOAuth2Store.setLastReceivedResponse');
    try {
      return super.setLastReceivedResponse(response);
    } finally {
      _$_DiscordOAuth2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOAuth2Helper(OAuth2Helper oAuth2Helper) {
    final _$actionInfo = _$_DiscordOAuth2StoreActionController.startAction(
        name: '_DiscordOAuth2Store.setOAuth2Helper');
    try {
      return super.setOAuth2Helper(oAuth2Helper);
    } finally {
      _$_DiscordOAuth2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDiscordUserGuilds(List<DiscordGuild> list) {
    final _$actionInfo = _$_DiscordOAuth2StoreActionController.startAction(
        name: '_DiscordOAuth2Store.setDiscordUserGuilds');
    try {
      return super.setDiscordUserGuilds(list);
    } finally {
      _$_DiscordOAuth2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserOAuth2ReponseURL(String url) {
    final _$actionInfo = _$_DiscordOAuth2StoreActionController.startAction(
        name: '_DiscordOAuth2Store.setUserOAuth2ReponseURL');
    try {
      return super.setUserOAuth2ReponseURL(url);
    } finally {
      _$_DiscordOAuth2StoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
usersGuilds: ${usersGuilds},
lastReceivedResponse: ${lastReceivedResponse},
oAuth2Helper: ${oAuth2Helper},
discordUserFuture: ${discordUserFuture},
discordGuildsFuture: ${discordGuildsFuture},
discordUserGuilds: ${discordUserGuilds},
userOAuth2ReponseURL: ${userOAuth2ReponseURL},
isLoggedIn: ${isLoggedIn},
userDetailsReady: ${userDetailsReady},
headers: ${headers}
    ''';
  }
}
