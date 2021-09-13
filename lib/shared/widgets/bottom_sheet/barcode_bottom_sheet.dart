import 'package:flutter/material.dart';

import 'package:payflow/shared/theme.dart';
import 'package:payflow/shared/widgets/buttons/set_label_buttons.dart';

class BarcodeBottomSheet extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnTap;
  final String secondaryLabel;
  final VoidCallback secondaryOnTap;
  final String title;
  final String subtitle;
  const BarcodeBottomSheet({
    required this.primaryLabel,
    required this.primaryOnTap,
    required this.secondaryLabel,
    required this.secondaryOnTap,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SafeArea(
        child: RotatedBox(
          quarterTurns: constraints.maxWidth < 650 ? 1 : 0,
          child: Material(
            child: Container(
              color: AppColors.shape,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Text.rich(
                      TextSpan(
                        text: title,
                        style: TextStyles.buttonBoldHeading,
                        children: [
                          TextSpan(
                            text: '\n$subtitle',
                            style: TextStyles.buttonHeading,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    height: 1,
                    color: AppColors.stroke,
                  ),
                  SetLabelButtons(
                    primaryColor: 0,
                    primaryLabel: primaryLabel,
                    primaryOnTap: primaryOnTap,
                    secondaryLabel: secondaryLabel,
                    secondaryOnTap: secondaryOnTap,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
