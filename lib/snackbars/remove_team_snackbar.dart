import 'package:clash_bot_api/api.dart';
import 'package:flutter/material.dart';

SnackBar removeFromTeam(
    Role role, String playerId, String teamName, String serverId) {
  return SnackBar(
    content:
        Text('Removing you from the Role: ${role.toString().split('.').last}'),
  );
}
