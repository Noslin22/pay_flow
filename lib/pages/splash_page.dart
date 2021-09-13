import 'package:flutter/material.dart';
import 'package:payflow_mobx/controllers/auth_controller.dart';
import 'package:payflow_mobx/shared/theme.dart';

class SplashPage extends StatelessWidget {
  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    authController.currentUser(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(
            child: Image.asset(AppImages.union),
          ),
          Center(
            child: Image.asset(AppImages.logoFull),
          )
        ],
      ),
    );
  }
}
