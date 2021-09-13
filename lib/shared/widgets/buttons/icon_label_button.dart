import 'package:flutter/material.dart';
import 'package:payflow_mobx/shared/themes/app_text_styles.dart';

class IconLabelButton extends StatelessWidget {
  final EdgeInsets? padding;
  final VoidCallback onTap;
  final TextStyle? style;
  final String label;
  final Icon? icon;
  const IconLabelButton({
    required this.label,
    required this.onTap,
    this.padding,
    this.style,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Container(
            height: 56,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? Container(),
                Text(
                  label,
                  style: style ?? TextStyles.buttonHeading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
