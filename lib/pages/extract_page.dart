import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:payflow_hive/controllers/boleto_list_controller.dart';
import 'package:payflow_hive/shared/theme.dart';
import 'package:payflow_hive/shared/widgets/boleto/boleto_list.dart';
import 'package:payflow_hive/shared/widgets/divider_vertical.dart';
import 'package:payflow_hive/shared/widgets/buttons/icon_label_button.dart';

class ExtractPage extends StatelessWidget {
  final BoletoController controller;
  ExtractPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 24, left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Meus extratos',
                  style: TextStyles.titleBoldHeading,
                ),
                Observer(builder: (_) {
                  int payed = controller.boletos.length;
                  return Text(
                    "$payed pago${payed > 1 || payed == 0 ? 's' : ''}",
                    style: TextStyles.captionBody,
                    textAlign: TextAlign.right,
                  );
                })
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
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
              callAlert: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.only(top: 24),
                      title: Text(
                          'Deseja deletar o extrato ${controller.boleto.name!}?'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Divider(
                            color: AppColors.stroke,
                            height: 1,
                            thickness: 1,
                          ),
                          Container(
                            height: 56,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: IconLabelButton(
                                    label: 'Cancelar',
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    style: TextStyles.buttonGray,
                                  ),
                                ),
                                DividerVertical(),
                                Expanded(
                                  child: IconLabelButton(
                                    label: 'Deletar',
                                    onTap: () {
                                      controller.deleteExtrato();
                                      Navigator.pop(context);
                                    },
                                    style: TextStyles.buttonDelete,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
