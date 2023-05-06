// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discord_details.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DiscordDetailsStore on _DiscordDetailsStore, Store {
  Computed<bool>? _$detailsLoadedComputed;

  @override
  bool get detailsLoaded =>
      (_$detailsLoadedComputed ??= Computed<bool>(() => super.detailsLoaded,
              name: '_DiscordDetailsStore.detailsLoaded'))
          .value;
  Computed<bool>? _$guildDetailsLoadedComputed;

  @override
  bool get guildDetailsLoaded => (_$guildDetailsLoadedComputed ??=
          Computed<bool>(() => super.guildDetailsLoaded,
              name: '_DiscordDetailsStore.guildDetailsLoaded'))
      .value;
  Computed<Map<String, DiscordGuild>>? _$discordGuildMapComputed;

  @override
  Map<String, DiscordGuild> get discordGuildMap =>
      (_$discordGuildMapComputed ??= Computed<Map<String, DiscordGuild>>(
              () => super.discordGuildMap,
              name: '_DiscordDetailsStore.discordGuildMap'))
          .value;

  late final _$discordUserAtom =
      Atom(name: '_DiscordDetailsStore.discordUser', context: context);

  @override
  DiscordUser get discordUser {
    _$discordUserAtom.reportRead();
    return super.discordUser;
  }

  @override
  set discordUser(DiscordUser value) {
    _$discordUserAtom.reportWrite(value, super.discordUser, () {
      super.discordUser = value;
    });
  }

  late final _$discordGuildsAtom =
      Atom(name: '_DiscordDetailsStore.discordGuilds', context: context);

  @override
  ObservableList<DiscordGuild> get discordGuilds {
    _$discordGuildsAtom.reportRead();
    return super.discordGuilds;
  }

  @override
  set discordGuilds(ObservableList<DiscordGuild> value) {
    _$discordGuildsAtom.reportWrite(value, super.discordGuilds, () {
      super.discordGuilds = value;
    });
  }

  late final _$discordIdToNameAtom =
      Atom(name: '_DiscordDetailsStore.discordIdToName', context: context);

  @override
  ObservableMap<String, String> get discordIdToName {
    _$discordIdToNameAtom.reportRead();
    return super.discordIdToName;
  }

  @override
  set discordIdToName(ObservableMap<String, String> value) {
    _$discordIdToNameAtom.reportWrite(value, super.discordIdToName, () {
      super.discordIdToName = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_DiscordDetailsStore.status', context: context);

  @override
  String get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$fetchUserDetailsAsyncAction =
      AsyncAction('_DiscordDetailsStore.fetchUserDetails', context: context);

  @override
  Future<DiscordUser> fetchUserDetails(String discordId) {
    return _$fetchUserDetailsAsyncAction
        .run(() => super.fetchUserDetails(discordId));
  }

  late final _$fetchCurrentUserDetailsAsyncAction = AsyncAction(
      '_DiscordDetailsStore.fetchCurrentUserDetails',
      context: context);

  @override
  Future<void> fetchCurrentUserDetails() {
    return _$fetchCurrentUserDetailsAsyncAction
        .run(() => super.fetchCurrentUserDetails());
  }

  late final _$fetchUserGuildsAsyncAction =
      AsyncAction('_DiscordDetailsStore.fetchUserGuilds', context: context);

  @override
  Future<void> fetchUserGuilds() {
    return _$fetchUserGuildsAsyncAction.run(() => super.fetchUserGuilds());
  }

  late final _$loadEverythingAsyncAction =
      AsyncAction('_DiscordDetailsStore.loadEverything', context: context);

  @override
  Future<void> loadEverything() {
    return _$loadEverythingAsyncAction.run(() => super.loadEverything());
  }

  @override
  String toString() {
    return '''
discordUser: ${discordUser},
discordGuilds: ${discordGuilds},
discordIdToName: ${discordIdToName},
status: ${status},
detailsLoaded: ${detailsLoaded},
guildDetailsLoaded: ${guildDetailsLoaded},
discordGuildMap: ${discordGuildMap}
    ''';
  }
}
