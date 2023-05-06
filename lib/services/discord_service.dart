import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/discord_user.dart';

abstract class DiscordService {
  Future<DiscordUser> fetchCurrentUserDetails();

  Future<List<DiscordGuild>> fetchUserGuilds();

  Future<DiscordUser> fetchUserDetails(String discordId);

  Future<void> loginToDiscord();
}
