import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/controllers/login_controller.dart';
import 'package:payflow/shared/theme.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/buttons/social_login_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LoginController loginController = LoginController();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              color: AppColors.primary,
              height: size.height * 0.36,
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Image.asset(
                AppImages.person,
                width: 208,
                height: 300,
              ),
            ),
            Positioned(
              bottom: size.height * 0.01,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logomini),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70),
                    child: Text(
                      'Organize seus boletos em um só lugar',
                      textAlign: TextAlign.center,
                      style: TextStyles.titleHome,
                    ),
                  ),
                  AnimatedCard(
                    direction: AnimatedCardDirection.bottom,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 40,
                      ),
                      child: SocialLoginButton(
                        onTap: () {
                          loginController.googleSignIn(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
