import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow_mobx/controllers/auth_controller.dart';
import 'package:payflow_mobx/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final _authController = AuthController();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? response = await _googleSignIn.signIn();

      final user = UserModel(
        name: response!.displayName!,
        photoURL: response.photoUrl,
        email: response.email,
      );
      _authController.setUser(user: user, context: context);
    } catch (error) {
      print(error);
      _authController.setUser(user: null, context: context);
    }
  }

  Future<void> googleSignOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
      prefs.remove('user');
      _authController.setUser(user: null, context: context);
    } catch (error) {
      _authController.setUser(user: null, context: context);
    }
  }
}
