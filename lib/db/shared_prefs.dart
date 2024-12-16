import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  setUser(bool value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setBool('USER', value);
  }

  getUser() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    bool? userStatus = instance.getBool('USER');

    return userStatus ?? false;
  }
}