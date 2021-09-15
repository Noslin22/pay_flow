import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:payflow_hive/controllers/boleto_list_controller.dart';
import 'package:payflow_hive/shared/theme.dart';
import 'package:payflow_hive/shared/widgets/boleto/boleto_info.dart';
import 'package:payflow_hive/shared/widgets/boleto/boleto_list.dart';

class MeusBoletosPage extends StatelessWidget {
  final BoletoController controller;
  const MeusBoletosPage({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 40,
                    width: double.maxFinite,
                    color: AppColors.primary,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Observer(
                      builder: (_) => AnimatedCard(
                        child: BoletoInfo(size: controller.boletos.length),
                        direction: AnimatedCardDirection.top,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                child: Row(
                  children: [
                    Text(
                      'Meus boletos',
                      style: TextStyles.titleBoldHeading,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.stroke,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: BoletoList(
                  controller: controller,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
