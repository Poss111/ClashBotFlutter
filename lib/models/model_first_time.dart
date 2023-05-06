import 'package:clashbot_flutter/models/first_time.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class ModelFirstTime extends ChangeNotifier {
  bool _visited = false;
  late FirstTime _firstTime;
  bool get visited => _visited;

  ModelFirstTime() {
    _firstTime = FirstTime();
    isNewUser();
  }

  set visited(bool value) {
    _visited = value;
    _firstTime.setUserHasVisited();
    notifyListeners();
  }

  Future<bool> isNewUser() async {
    _visited = await _firstTime.getUserHasVisited();
    notifyListeners();
    return _visited;
  }
}
