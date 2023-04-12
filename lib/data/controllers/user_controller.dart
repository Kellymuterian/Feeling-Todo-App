import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';

ValueNotifier<User> activeUser = ValueNotifier(User());

class UserController {
  setUserInCache(User user) async {
    activeUser.value = user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', user.api_token!);
    prefs.setString('user', json.encode(user.toMap()));
  }

  getUserFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    activeUser.value = User.fromMap(json.decode(prefs.getString("user")!));
  }
}
