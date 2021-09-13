import 'package:flutter/material.dart';

import 'package:payflow_mobx/shared/theme.dart';
import 'package:payflow_mobx/shared/themes/app_text_styles.dart';
import 'package:payflow_mobx/shared/widgets/divider_vertical.dart';
import 'package:payflow_mobx/shared/widgets/buttons/icon_label_button.dart';

class SetLabelButtons extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnTap;
  final String secondaryLabel;
  final VoidCallback secondaryOnTap;
  final int primaryColor;

  const SetLabelButtons({
    required this.primaryLabel,
    required this.primaryOnTap,
    required this.secondaryLabel,
    required this.secondaryOnTap,
    this.primaryColor = -1,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      height: 57,
      child: Column(
        children: [
          Divider(
            thickness: 1,
            height: 1,
            color: AppColors.stroke,
          ),
          Container(
            height: 56,
            child: Row(
              children: [
                Expanded(
                  child: IconLabelButton(
                    label: primaryLabel,
                    onTap: primaryOnTap,
                    style: primaryColor == 0 ? TextStyles.buttonPrimary : null,
                  ),
                ),
                DividerVertical(),
                Expanded(
                  child: IconLabelButton(
                    label: secondaryLabel,
                    onTap: secondaryOnTap,
                    style: primaryColor == 1 ? TextStyles.buttonPrimary : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
