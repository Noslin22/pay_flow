import 'package:flutter/material.dart';
import 'package:payflow_hive/shared/theme.dart';

class DividerVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: double.maxFinite,
      color: AppColors.stroke,
    );
  }
}
