import 'package:flutter/material.dart';
import 'package:payflow_hive/shared/theme.dart';

class BoletoInfo extends StatelessWidget {
  final int size;
  const BoletoInfo({
    required this.size,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: constraints.maxWidth >= 400
              ? EdgeInsets.symmetric(vertical: 24)
              : EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                AppImages.logomini,
                color: AppColors.background,
                width: 56,
                height: 34,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: 1,
                  height: 32,
                  color: AppColors.background,
                ),
              ),
              Flexible(
                child: Text.rich(TextSpan(
                  text: "Você tem ",
                  style: TextStyles.captionBackground,
                  children: [
                    TextSpan(
                      text: "$size boleto${size > 1 || size == 0 ? 's' : ''} ",
                      style: TextStyles.captionBoldBackground,
                    ),
                    TextSpan(
                      text:
                          "cadastrado${size > 1 || size == 0 ? 's' : ''} para pagar",
                      style: TextStyles.captionBackground,
                    ),
                  ],
                )),
              )
            ],
          ),
        );
      }),
    );
  }
}
