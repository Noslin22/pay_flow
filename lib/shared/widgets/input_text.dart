import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';

import 'package:payflow_mobx/shared/theme.dart';

class InputText extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value) onChanged;

  InputText({
    required this.onChanged,
    required this.label,
    required this.icon,
    this.initialValue,
    this.controller,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Column(
        children: [
          TextFormField(
            onChanged: onChanged,
            controller: controller,
            validator: validator,
            initialValue: initialValue,
            style: TextStyles.input,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyles.input,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Icon(
                      icon,
                      color: AppColors.primary,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 48,
                    color: AppColors.stroke,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.stroke,
          )
        ],
      ),
    );
  }
}
