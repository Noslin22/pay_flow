import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:payflow_hive/shared/models/user_model.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthController with _$AuthController;

abstract class _AuthController with Store {
  @observable
  UserModel? userModel;

  @action
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
    final userBox = Hive.box<UserModel>('user');
    userBox.put('user', user);
    return;
  }

  @action
  Future<void> currentUser(BuildContext context) async {
    final userBox = Hive.box<UserModel>('user');
    await Future.delayed(Duration(seconds: 1));
    if (userBox.isOpen) {
      setUser(user: userBox.get('user'), context: context);
      return;
    } else {
      setUser(user: null, context: context);
    }
  }
}
