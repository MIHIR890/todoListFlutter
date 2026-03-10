import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/view_model/authentication_view_model.dart';

class LocalStorageService {

  static const String loginKey = "is_logged_in";

  /// save login state local

  Future<void> saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loginKey, true);

    if(kDebugMode){
      print("Saving Login Data");
    }
  }


  /// check if logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    if(kDebugMode){
      print("Saved  Login Data ${prefs.get(loginKey)}");
    }
    return prefs.getBool(loginKey) ?? false;

  }

  /// clear state
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loginKey, false);

    if (kDebugMode) {
      print("Login state cleared ");
    }
  }
}