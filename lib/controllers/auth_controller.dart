import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  ValueNotifier<UserModel?> _userNotifier = ValueNotifier<UserModel?>(null);
  UserModel? get userModel => _userNotifier.value;
  set userModel(UserModel? userModel) => _userNotifier.value = userModel;

  void setUser({required UserModel? user, required BuildContext context}) {
    if (user != null) {
      userModel = user;
      saveUser(user);
      Navigator.pushReplacementNamed(context, '/home', arguments: user);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 3));
    if (prefs.containsKey('user')) {
      final user = prefs.getString("user") as String;
      setUser(user: UserModel.fromJson(user), context: context);
      return;
    } else {
      setUser(user: null, context: context);
    }
  }
}
