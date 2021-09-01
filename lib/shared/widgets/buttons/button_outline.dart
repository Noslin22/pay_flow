import 'package:flutter/material.dart';

class ButtonOutline extends StatelessWidget {
  final EdgeInsets? padding;
  final VoidCallback onTap;
  final Color? borderColor;
  final Color? color;
  final Widget child;
  const ButtonOutline({
    required this.child,
    required this.onTap,
    this.borderColor,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color ?? primaryColor,
          border: Border.all(
            color: borderColor ?? color ?? primaryColor,
          ),
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.all(12),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
