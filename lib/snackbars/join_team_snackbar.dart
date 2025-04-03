import 'package:clash_bot_api/api.dart';
import 'package:flutter/material.dart';

SnackBar joinTeam(
    Role role, String? playerId, String teamName, String serverId) {
  return SnackBar(
    content:
        Text('Adding you to Team as Role: ${role.toString().split('.').last}'),
  );
}
