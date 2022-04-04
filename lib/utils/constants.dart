import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextStyle kLinkText = TextStyle(color: Colors.blue);

class HelperConstants {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAIL";

  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        HelperConstants.sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<Object?> getUerLoggedInSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences
        .get(HelperConstants.sharedPreferenceUserLoggedInKey);
  }
}
