import 'package:clash_bot_api/api.dart';

class ClashBotUser {
  ClashBotUser({
    this.discordId,
    this.role,
    this.champions = const [],
    this.subscriptions = const [],
    this.serverId,
    this.selectedServers = const []
  });

  /// Discord Id for the Player
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? discordId;

  ///
/// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Role? role;

  /// A list of the Users preferred champions.
  List<Champion> champions;

  List<Subscription> subscriptions;

  /// The Discord Server id that the User is defaulted to.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? serverId;

  /// The list of available Discord Servers for the player to filter by.
  List<String> selectedServers;
  
}