import 'package:flutter/material.dart';

import 'package:payflow_hive/shared/theme.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;

  const SocialLoginButton({required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.shape,
          borderRadius: BorderRadius.circular(5),
          border: Border.fromBorderSide(
            BorderSide(
              color: AppColors.stroke,
            ),
          ),
        ),
        height: 56,
        child: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset(AppImages.google),
                ),
                Container(
                  height: 56,
                  width: 1,
                  color: AppColors.stroke,
                )
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Entrar com Google',
                    style: TextStyles.buttonGray,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
