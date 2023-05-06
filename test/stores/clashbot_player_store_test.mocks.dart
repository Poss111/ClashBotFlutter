// Mocks generated by Mockito 5.4.0 from annotations
// in clashbot_flutter/test/stores/clashbot_player_store_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i12;

import 'package:clash_bot_api/api.dart' as _i13;
import 'package:clashbot_flutter/models/clash_notification.dart' as _i16;
import 'package:clashbot_flutter/models/clash_team.dart' as _i3;
import 'package:clashbot_flutter/models/clash_tournament.dart' as _i14;
import 'package:clashbot_flutter/models/clashbot_user.dart' as _i2;
import 'package:clashbot_flutter/models/discord_guild.dart' as _i18;
import 'package:clashbot_flutter/models/discord_user.dart' as _i9;
import 'package:clashbot_flutter/models/lol_champion.dart' as _i10;
import 'package:clashbot_flutter/models/tentative_queue.dart' as _i4;
import 'package:clashbot_flutter/services/clashbot_service.dart' as _i11;
import 'package:clashbot_flutter/stores/application_details.store.dart' as _i15;
import 'package:clashbot_flutter/stores/clashbot_player.store.dart' as _i6;
import 'package:clashbot_flutter/stores/discord_details.store.dart' as _i5;
import 'package:clashbot_flutter/stores/riot_champion.store.dart' as _i7;
import 'package:mobx/mobx.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;

import 'clashbot_player_store_test.dart' as _i17;

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

class _FakeClashBotUser_0 extends _i1.SmartFake implements _i2.ClashBotUser {
  _FakeClashBotUser_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeClashTeam_1 extends _i1.SmartFake implements _i3.ClashTeam {
  _FakeClashTeam_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTentativeQueue_2 extends _i1.SmartFake
    implements _i4.TentativeQueue {
  _FakeTentativeQueue_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDiscordDetailsStore_3 extends _i1.SmartFake
    implements _i5.DiscordDetailsStore {
  _FakeDiscordDetailsStore_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeClashPlayerStore_4 extends _i1.SmartFake
    implements _i6.ClashPlayerStore {
  _FakeClashPlayerStore_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRiotChampionStore_5 extends _i1.SmartFake
    implements _i7.RiotChampionStore {
  _FakeRiotChampionStore_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeObservableList_6<T> extends _i1.SmartFake
    implements _i8.ObservableList<T> {
  _FakeObservableList_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeReactiveContext_7 extends _i1.SmartFake
    implements _i8.ReactiveContext {
  _FakeReactiveContext_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDiscordUser_8 extends _i1.SmartFake implements _i9.DiscordUser {
  _FakeDiscordUser_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLoLChampionsData_9 extends _i1.SmartFake
    implements _i10.LoLChampionsData {
  _FakeLoLChampionsData_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ClashBotService].
///
/// See the documentation for Mockito's code generation for more information.
class MockClashBotService extends _i1.Mock implements _i11.ClashBotService {
  MockClashBotService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.Future<_i2.ClashBotUser> getPlayer(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getPlayer,
          [id],
        ),
        returnValue: _i12.Future<_i2.ClashBotUser>.value(_FakeClashBotUser_0(
          this,
          Invocation.method(
            #getPlayer,
            [id],
          ),
        )),
      ) as _i12.Future<_i2.ClashBotUser>);
  @override
  _i12.Future<_i2.ClashBotUser> createPlayer(
    String? id,
    String? name,
    String? defaultServerId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createPlayer,
          [
            id,
            name,
            defaultServerId,
          ],
        ),
        returnValue: _i12.Future<_i2.ClashBotUser>.value(_FakeClashBotUser_0(
          this,
          Invocation.method(
            #createPlayer,
            [
              id,
              name,
              defaultServerId,
            ],
          ),
        )),
      ) as _i12.Future<_i2.ClashBotUser>);
  @override
  _i12.Future<List<String>> createSelectedServers(
    String? id,
    List<String>? selectedServers,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createSelectedServers,
          [
            id,
            selectedServers,
          ],
        ),
        returnValue: _i12.Future<List<String>>.value(<String>[]),
      ) as _i12.Future<List<String>>);
  @override
  _i12.Future<List<String>> updateSelectedServers(
    String? id,
    List<String>? selectedServers,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateSelectedServers,
          [
            id,
            selectedServers,
          ],
        ),
        returnValue: _i12.Future<List<String>>.value(<String>[]),
      ) as _i12.Future<List<String>>);
  @override
  _i12.Future<List<String>> removeSelectedServers(
    String? id,
    List<String>? selectedServers,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeSelectedServers,
          [
            id,
            selectedServers,
          ],
        ),
        returnValue: _i12.Future<List<String>>.value(<String>[]),
      ) as _i12.Future<List<String>>);
  @override
  _i12.Future<List<String>> getChampions(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getChampions,
          [id],
        ),
        returnValue: _i12.Future<List<String>>.value(<String>[]),
      ) as _i12.Future<List<String>>);
  @override
  _i12.Future<List<String>> updateChampions(
    String? id,
    String? champion,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateChampions,
          [
            id,
            champion,
          ],
        ),
        returnValue: _i12.Future<List<String>>.value(<String>[]),
      ) as _i12.Future<List<String>>);
  @override
  _i12.Future<List<String>> overwriteChampions(
    String? id,
    List<String>? champions,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #overwriteChampions,
          [
            id,
            champions,
          ],
        ),
        returnValue: _i12.Future<List<String>>.value(<String>[]),
      ) as _i12.Future<List<String>>);
  @override
  _i12.Future<List<String>> removeChampion(
    String? id,
    String? champion,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeChampion,
          [
            id,
            champion,
          ],
        ),
        returnValue: _i12.Future<List<String>>.value(<String>[]),
      ) as _i12.Future<List<String>>);
  @override
  _i12.Future<Map<String, bool>> getSubscriptions(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getSubscriptions,
          [id],
        ),
        returnValue: _i12.Future<Map<String, bool>>.value(<String, bool>{}),
      ) as _i12.Future<Map<String, bool>>);
  @override
  _i12.Future<_i13.Subscription?> unsubscribe(
    String? id,
    _i13.SubscriptionType? type,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #unsubscribe,
          [
            id,
            type,
          ],
        ),
        returnValue: _i12.Future<_i13.Subscription?>.value(),
      ) as _i12.Future<_i13.Subscription?>);
  @override
  _i12.Future<_i13.Subscription?> subscribe(
    String? id,
    _i13.SubscriptionType? type,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #subscribe,
          [
            id,
            type,
          ],
        ),
        returnValue: _i12.Future<_i13.Subscription?>.value(),
      ) as _i12.Future<_i13.Subscription?>);
  @override
  _i12.Future<List<_i3.ClashTeam>> getClashTeams(
    String? id,
    List<String>? selectedServerIds,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getClashTeams,
          [
            id,
            selectedServerIds,
          ],
        ),
        returnValue: _i12.Future<List<_i3.ClashTeam>>.value(<_i3.ClashTeam>[]),
      ) as _i12.Future<List<_i3.ClashTeam>>);
  @override
  _i12.Future<_i3.ClashTeam> createClashTeam(
    String? discordId,
    String? name,
    _i13.Role? role,
    String? serverId,
    String? tournamentName,
    String? tournamentDay,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createClashTeam,
          [
            discordId,
            name,
            role,
            serverId,
            tournamentName,
            tournamentDay,
          ],
        ),
        returnValue: _i12.Future<_i3.ClashTeam>.value(_FakeClashTeam_1(
          this,
          Invocation.method(
            #createClashTeam,
            [
              discordId,
              name,
              role,
              serverId,
              tournamentName,
              tournamentDay,
            ],
          ),
        )),
      ) as _i12.Future<_i3.ClashTeam>);
  @override
  _i12.Future<_i3.ClashTeam> addToTeam(
    String? id,
    _i13.Role? role,
    String? teamId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addToTeam,
          [
            id,
            role,
            teamId,
          ],
        ),
        returnValue: _i12.Future<_i3.ClashTeam>.value(_FakeClashTeam_1(
          this,
          Invocation.method(
            #addToTeam,
            [
              id,
              role,
              teamId,
            ],
          ),
        )),
      ) as _i12.Future<_i3.ClashTeam>);
  @override
  _i12.Future<_i3.ClashTeam> removeFromTeam(
    String? id,
    String? teamId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromTeam,
          [
            id,
            teamId,
          ],
        ),
        returnValue: _i12.Future<_i3.ClashTeam>.value(_FakeClashTeam_1(
          this,
          Invocation.method(
            #removeFromTeam,
            [
              id,
              teamId,
            ],
          ),
        )),
      ) as _i12.Future<_i3.ClashTeam>);
  @override
  _i12.Future<List<_i4.TentativeQueue>> getTentativeQueues(
    String? id,
    List<String>? selectedServerIds,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTentativeQueues,
          [
            id,
            selectedServerIds,
          ],
        ),
        returnValue:
            _i12.Future<List<_i4.TentativeQueue>>.value(<_i4.TentativeQueue>[]),
      ) as _i12.Future<List<_i4.TentativeQueue>>);
  @override
  _i12.Future<_i4.TentativeQueue> createTentativeQueue(
    String? discordId,
    String? serverId,
    String? tournamentName,
    String? tournamentDay,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTentativeQueue,
          [
            discordId,
            serverId,
            tournamentName,
            tournamentDay,
          ],
        ),
        returnValue:
            _i12.Future<_i4.TentativeQueue>.value(_FakeTentativeQueue_2(
          this,
          Invocation.method(
            #createTentativeQueue,
            [
              discordId,
              serverId,
              tournamentName,
              tournamentDay,
            ],
          ),
        )),
      ) as _i12.Future<_i4.TentativeQueue>);
  @override
  _i12.Future<_i4.TentativeQueue> addToTentativeQueue(
    String? id,
    String? tentativeId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addToTentativeQueue,
          [
            id,
            tentativeId,
          ],
        ),
        returnValue:
            _i12.Future<_i4.TentativeQueue>.value(_FakeTentativeQueue_2(
          this,
          Invocation.method(
            #addToTentativeQueue,
            [
              id,
              tentativeId,
            ],
          ),
        )),
      ) as _i12.Future<_i4.TentativeQueue>);
  @override
  _i12.Future<_i4.TentativeQueue> removeFromTentativeQueue(
    String? id,
    String? tentativeId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromTentativeQueue,
          [
            id,
            tentativeId,
          ],
        ),
        returnValue:
            _i12.Future<_i4.TentativeQueue>.value(_FakeTentativeQueue_2(
          this,
          Invocation.method(
            #removeFromTentativeQueue,
            [
              id,
              tentativeId,
            ],
          ),
        )),
      ) as _i12.Future<_i4.TentativeQueue>);
  @override
  _i12.Future<List<_i14.ClashTournament>> retrieveTournaments(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #retrieveTournaments,
          [id],
        ),
        returnValue: _i12.Future<List<_i14.ClashTournament>>.value(
            <_i14.ClashTournament>[]),
      ) as _i12.Future<List<_i14.ClashTournament>>);
}

/// A class which mocks [ApplicationDetailsStore].
///
/// See the documentation for Mockito's code generation for more information.
class MockApplicationDetailsStore extends _i1.Mock
    implements _i15.ApplicationDetailsStore {
  MockApplicationDetailsStore() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.DiscordDetailsStore get discordDetailsStore => (super.noSuchMethod(
        Invocation.getter(#discordDetailsStore),
        returnValue: _FakeDiscordDetailsStore_3(
          this,
          Invocation.getter(#discordDetailsStore),
        ),
      ) as _i5.DiscordDetailsStore);
  @override
  set discordDetailsStore(_i5.DiscordDetailsStore? _discordDetailsStore) =>
      super.noSuchMethod(
        Invocation.setter(
          #discordDetailsStore,
          _discordDetailsStore,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.ClashPlayerStore get loggedInClashUser => (super.noSuchMethod(
        Invocation.getter(#loggedInClashUser),
        returnValue: _FakeClashPlayerStore_4(
          this,
          Invocation.getter(#loggedInClashUser),
        ),
      ) as _i6.ClashPlayerStore);
  @override
  set loggedInClashUser(_i6.ClashPlayerStore? _loggedInClashUser) =>
      super.noSuchMethod(
        Invocation.setter(
          #loggedInClashUser,
          _loggedInClashUser,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i7.RiotChampionStore get riotChampionStore => (super.noSuchMethod(
        Invocation.getter(#riotChampionStore),
        returnValue: _FakeRiotChampionStore_5(
          this,
          Invocation.getter(#riotChampionStore),
        ),
      ) as _i7.RiotChampionStore);
  @override
  set riotChampionStore(_i7.RiotChampionStore? _riotChampionStore) =>
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
  _i8.ObservableList<_i14.ClashTournament> get tournaments =>
      (super.noSuchMethod(
        Invocation.getter(#tournaments),
        returnValue: _FakeObservableList_6<_i14.ClashTournament>(
          this,
          Invocation.getter(#tournaments),
        ),
      ) as _i8.ObservableList<_i14.ClashTournament>);
  @override
  set tournaments(_i8.ObservableList<_i14.ClashTournament>? _tournaments) =>
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
  _i8.ObservableList<_i16.ClashNotification> get notifications =>
      (super.noSuchMethod(
        Invocation.getter(#notifications),
        returnValue: _FakeObservableList_6<_i16.ClashNotification>(
          this,
          Invocation.getter(#notifications),
        ),
      ) as _i8.ObservableList<_i16.ClashNotification>);
  @override
  set notifications(
          _i8.ObservableList<_i16.ClashNotification>? _notifications) =>
      super.noSuchMethod(
        Invocation.setter(
          #notifications,
          _notifications,
        ),
        returnValueForMissingStub: null,
      );
  @override
  List<_i16.ClashNotification> get sortedNotifications => (super.noSuchMethod(
        Invocation.getter(#sortedNotifications),
        returnValue: <_i16.ClashNotification>[],
      ) as List<_i16.ClashNotification>);
  @override
  List<_i16.ClashNotification> get unreadNotifications => (super.noSuchMethod(
        Invocation.getter(#unreadNotifications),
        returnValue: <_i16.ClashNotification>[],
      ) as List<_i16.ClashNotification>);
  @override
  bool get isLoggedIn => (super.noSuchMethod(
        Invocation.getter(#isLoggedIn),
        returnValue: false,
      ) as bool);
  @override
  _i8.ReactiveContext get context => (super.noSuchMethod(
        Invocation.getter(#context),
        returnValue: _FakeReactiveContext_7(
          this,
          Invocation.getter(#context),
        ),
      ) as _i8.ReactiveContext);
  @override
  _i12.Future<void> getTournaments() => (super.noSuchMethod(
        Invocation.method(
          #getTournaments,
          [],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);
  @override
  void triggerError(String? errorMessage) => super.noSuchMethod(
        Invocation.method(
          #triggerError,
          [errorMessage],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyUser(_i16.ClashNotification? clashNotification) =>
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
  _i12.Future<void> loadUserDetails() => (super.noSuchMethod(
        Invocation.method(
          #loadUserDetails,
          [],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);
}

/// A class which mocks [DiscordServiceMock].
///
/// See the documentation for Mockito's code generation for more information.
class MockDiscordServiceMock extends _i1.Mock
    implements _i17.DiscordServiceMock {
  MockDiscordServiceMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.Future<_i9.DiscordUser> fetchCurrentUserDetails() => (super.noSuchMethod(
        Invocation.method(
          #fetchCurrentUserDetails,
          [],
        ),
        returnValue: _i12.Future<_i9.DiscordUser>.value(_FakeDiscordUser_8(
          this,
          Invocation.method(
            #fetchCurrentUserDetails,
            [],
          ),
        )),
      ) as _i12.Future<_i9.DiscordUser>);
  @override
  _i12.Future<List<_i18.DiscordGuild>> fetchUserGuilds() => (super.noSuchMethod(
        Invocation.method(
          #fetchUserGuilds,
          [],
        ),
        returnValue:
            _i12.Future<List<_i18.DiscordGuild>>.value(<_i18.DiscordGuild>[]),
      ) as _i12.Future<List<_i18.DiscordGuild>>);
  @override
  _i12.Future<_i9.DiscordUser> fetchUserDetails(String? discordId) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchUserDetails,
          [discordId],
        ),
        returnValue: _i12.Future<_i9.DiscordUser>.value(_FakeDiscordUser_8(
          this,
          Invocation.method(
            #fetchUserDetails,
            [discordId],
          ),
        )),
      ) as _i12.Future<_i9.DiscordUser>);
  @override
  _i12.Future<void> loginToDiscord() => (super.noSuchMethod(
        Invocation.method(
          #loginToDiscord,
          [],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);
}

/// A class which mocks [RiotResourcesServiceMock].
///
/// See the documentation for Mockito's code generation for more information.
class MockRiotResourcesServiceMock extends _i1.Mock
    implements _i17.RiotResourcesServiceMock {
  MockRiotResourcesServiceMock() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.Future<String> getLatestApiVersion() => (super.noSuchMethod(
        Invocation.method(
          #getLatestApiVersion,
          [],
        ),
        returnValue: _i12.Future<String>.value(''),
      ) as _i12.Future<String>);
  @override
  _i12.Future<_i10.LoLChampionsData> getChampionDetails() =>
      (super.noSuchMethod(
        Invocation.method(
          #getChampionDetails,
          [],
        ),
        returnValue:
            _i12.Future<_i10.LoLChampionsData>.value(_FakeLoLChampionsData_9(
          this,
          Invocation.method(
            #getChampionDetails,
            [],
          ),
        )),
      ) as _i12.Future<_i10.LoLChampionsData>);
}
