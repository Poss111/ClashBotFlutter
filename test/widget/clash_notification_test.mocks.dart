// Mocks generated by Mockito 5.4.0 from annotations
// in clashbot_flutter/test/widget/clash_notification_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;

import 'package:clashbot_flutter/models/clash_notification.dart' as _i9;
import 'package:clashbot_flutter/models/clash_tournament.dart' as _i8;
import 'package:clashbot_flutter/models/discord_guild.dart' as _i11;
import 'package:clashbot_flutter/models/discord_user.dart' as _i6;
import 'package:clashbot_flutter/stores/application_details.store.dart' as _i7;
import 'package:clashbot_flutter/stores/clashbot_player.store.dart' as _i3;
import 'package:clashbot_flutter/stores/discord_details.store.dart' as _i2;
import 'package:clashbot_flutter/stores/riot_champion.store.dart' as _i4;
import 'package:mobx/mobx.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDiscordDetailsStore_0 extends _i1.SmartFake
    implements _i2.DiscordDetailsStore {
  _FakeDiscordDetailsStore_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeClashPlayerStore_1 extends _i1.SmartFake
    implements _i3.ClashPlayerStore {
  _FakeClashPlayerStore_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRiotChampionStore_2 extends _i1.SmartFake
    implements _i4.RiotChampionStore {
  _FakeRiotChampionStore_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeObservableList_3<T> extends _i1.SmartFake
    implements _i5.ObservableList<T> {
  _FakeObservableList_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeReactiveContext_4 extends _i1.SmartFake
    implements _i5.ReactiveContext {
  _FakeReactiveContext_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDiscordUser_5 extends _i1.SmartFake implements _i6.DiscordUser {
  _FakeDiscordUser_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeObservableMap_6<K, V> extends _i1.SmartFake
    implements _i5.ObservableMap<K, V> {
  _FakeObservableMap_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ApplicationDetailsStore].
///
/// See the documentation for Mockito's code generation for more information.
class MockApplicationDetailsStore extends _i1.Mock
    implements _i7.ApplicationDetailsStore {
  MockApplicationDetailsStore() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DiscordDetailsStore get discordDetailsStore => (super.noSuchMethod(
        Invocation.getter(#discordDetailsStore),
        returnValue: _FakeDiscordDetailsStore_0(
          this,
          Invocation.getter(#discordDetailsStore),
        ),
      ) as _i2.DiscordDetailsStore);
  @override
  set discordDetailsStore(_i2.DiscordDetailsStore? _discordDetailsStore) =>
      super.noSuchMethod(
        Invocation.setter(
          #discordDetailsStore,
          _discordDetailsStore,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.ClashPlayerStore get loggedInClashUser => (super.noSuchMethod(
        Invocation.getter(#loggedInClashUser),
        returnValue: _FakeClashPlayerStore_1(
          this,
          Invocation.getter(#loggedInClashUser),
        ),
      ) as _i3.ClashPlayerStore);
  @override
  set loggedInClashUser(_i3.ClashPlayerStore? _loggedInClashUser) =>
      super.noSuchMethod(
        Invocation.setter(
          #loggedInClashUser,
          _loggedInClashUser,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.RiotChampionStore get riotChampionStore => (super.noSuchMethod(
        Invocation.getter(#riotChampionStore),
        returnValue: _FakeRiotChampionStore_2(
          this,
          Invocation.getter(#riotChampionStore),
        ),
      ) as _i4.RiotChampionStore);
  @override
  set riotChampionStore(_i4.RiotChampionStore? _riotChampionStore) =>
      super.noSuchMethod(
        Invocation.setter(
          #riotChampionStore,
          _riotChampionStore,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get id => (super.noSuchMethod(
        Invocation.getter(#id),
        returnValue: '',
      ) as String);
  @override
  set id(String? _id) => super.noSuchMethod(
        Invocation.setter(
          #id,
          _id,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.ObservableList<_i8.ClashTournament> get tournaments =>
      (super.noSuchMethod(
        Invocation.getter(#tournaments),
        returnValue: _FakeObservableList_3<_i8.ClashTournament>(
          this,
          Invocation.getter(#tournaments),
        ),
      ) as _i5.ObservableList<_i8.ClashTournament>);
  @override
  set tournaments(_i5.ObservableList<_i8.ClashTournament>? _tournaments) =>
      super.noSuchMethod(
        Invocation.setter(
          #tournaments,
          _tournaments,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get error => (super.noSuchMethod(
        Invocation.getter(#error),
        returnValue: '',
      ) as String);
  @override
  set error(String? _error) => super.noSuchMethod(
        Invocation.setter(
          #error,
          _error,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.ObservableList<_i9.ClashNotification> get notifications =>
      (super.noSuchMethod(
        Invocation.getter(#notifications),
        returnValue: _FakeObservableList_3<_i9.ClashNotification>(
          this,
          Invocation.getter(#notifications),
        ),
      ) as _i5.ObservableList<_i9.ClashNotification>);
  @override
  set notifications(
          _i5.ObservableList<_i9.ClashNotification>? _notifications) =>
      super.noSuchMethod(
        Invocation.setter(
          #notifications,
          _notifications,
        ),
        returnValueForMissingStub: null,
      );
  @override
  List<_i9.ClashNotification> get sortedNotifications => (super.noSuchMethod(
        Invocation.getter(#sortedNotifications),
        returnValue: <_i9.ClashNotification>[],
      ) as List<_i9.ClashNotification>);
  @override
  List<_i9.ClashNotification> get unreadNotifications => (super.noSuchMethod(
        Invocation.getter(#unreadNotifications),
        returnValue: <_i9.ClashNotification>[],
      ) as List<_i9.ClashNotification>);
  @override
  bool get isLoggedIn => (super.noSuchMethod(
        Invocation.getter(#isLoggedIn),
        returnValue: false,
      ) as bool);
  @override
  _i5.ReactiveContext get context => (super.noSuchMethod(
        Invocation.getter(#context),
        returnValue: _FakeReactiveContext_4(
          this,
          Invocation.getter(#context),
        ),
      ) as _i5.ReactiveContext);
  @override
  _i10.Future<void> getTournaments() => (super.noSuchMethod(
        Invocation.method(
          #getTournaments,
          [],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);
  @override
  void triggerError(String? errorMessage) => super.noSuchMethod(
        Invocation.method(
          #triggerError,
          [errorMessage],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyUser(_i9.ClashNotification? clashNotification) =>
      super.noSuchMethod(
        Invocation.method(
          #notifyUser,
          [clashNotification],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void readNotification(String? uuid) => super.noSuchMethod(
        Invocation.method(
          #readNotification,
          [uuid],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void unsubscribeFromServer(String? serverId) => super.noSuchMethod(
        Invocation.method(
          #unsubscribeFromServer,
          [serverId],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void subscribeToServer(String? serverId) => super.noSuchMethod(
        Invocation.method(
          #subscribeToServer,
          [serverId],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i10.Future<void> loadUserDetails() => (super.noSuchMethod(
        Invocation.method(
          #loadUserDetails,
          [],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);
}

/// A class which mocks [DiscordDetailsStore].
///
/// See the documentation for Mockito's code generation for more information.
class MockDiscordDetailsStore extends _i1.Mock
    implements _i2.DiscordDetailsStore {
  MockDiscordDetailsStore() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.DiscordUser get discordUser => (super.noSuchMethod(
        Invocation.getter(#discordUser),
        returnValue: _FakeDiscordUser_5(
          this,
          Invocation.getter(#discordUser),
        ),
      ) as _i6.DiscordUser);
  @override
  set discordUser(_i6.DiscordUser? _discordUser) => super.noSuchMethod(
        Invocation.setter(
          #discordUser,
          _discordUser,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.ObservableList<_i11.DiscordGuild> get discordGuilds =>
      (super.noSuchMethod(
        Invocation.getter(#discordGuilds),
        returnValue: _FakeObservableList_3<_i11.DiscordGuild>(
          this,
          Invocation.getter(#discordGuilds),
        ),
      ) as _i5.ObservableList<_i11.DiscordGuild>);
  @override
  set discordGuilds(_i5.ObservableList<_i11.DiscordGuild>? _discordGuilds) =>
      super.noSuchMethod(
        Invocation.setter(
          #discordGuilds,
          _discordGuilds,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.ObservableMap<String, String> get discordIdToName => (super.noSuchMethod(
        Invocation.getter(#discordIdToName),
        returnValue: _FakeObservableMap_6<String, String>(
          this,
          Invocation.getter(#discordIdToName),
        ),
      ) as _i5.ObservableMap<String, String>);
  @override
  set discordIdToName(_i5.ObservableMap<String, String>? _discordIdToName) =>
      super.noSuchMethod(
        Invocation.setter(
          #discordIdToName,
          _discordIdToName,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get status => (super.noSuchMethod(
        Invocation.getter(#status),
        returnValue: '',
      ) as String);
  @override
  set status(String? _status) => super.noSuchMethod(
        Invocation.setter(
          #status,
          _status,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get detailsLoaded => (super.noSuchMethod(
        Invocation.getter(#detailsLoaded),
        returnValue: false,
      ) as bool);
  @override
  bool get guildDetailsLoaded => (super.noSuchMethod(
        Invocation.getter(#guildDetailsLoaded),
        returnValue: false,
      ) as bool);
  @override
  Map<String, _i11.DiscordGuild> get discordGuildMap => (super.noSuchMethod(
        Invocation.getter(#discordGuildMap),
        returnValue: <String, _i11.DiscordGuild>{},
      ) as Map<String, _i11.DiscordGuild>);
  @override
  _i5.ReactiveContext get context => (super.noSuchMethod(
        Invocation.getter(#context),
        returnValue: _FakeReactiveContext_4(
          this,
          Invocation.getter(#context),
        ),
      ) as _i5.ReactiveContext);
  @override
  _i10.Future<_i6.DiscordUser> fetchUserDetails(String? discordId) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchUserDetails,
          [discordId],
        ),
        returnValue: _i10.Future<_i6.DiscordUser>.value(_FakeDiscordUser_5(
          this,
          Invocation.method(
            #fetchUserDetails,
            [discordId],
          ),
        )),
      ) as _i10.Future<_i6.DiscordUser>);
  @override
  _i10.Future<void> fetchCurrentUserDetails() => (super.noSuchMethod(
        Invocation.method(
          #fetchCurrentUserDetails,
          [],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);
  @override
  _i10.Future<void> fetchUserGuilds() => (super.noSuchMethod(
        Invocation.method(
          #fetchUserGuilds,
          [],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);
  @override
  _i10.Future<void> loadEverything() => (super.noSuchMethod(
        Invocation.method(
          #loadEverything,
          [],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);
}
