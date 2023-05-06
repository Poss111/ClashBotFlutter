import 'package:shared_preferences/shared_preferences.dart';

class FirstTime {
  static const VISITED_KEY = "visited";

  Future setUserHasVisited() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(VISITED_KEY, true);
  }

  Future<bool> getUserHasVisited() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(VISITED_KEY) ?? false;
  }
}