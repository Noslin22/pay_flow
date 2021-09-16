import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:payflow_hive/controllers/boleto_list_controller.dart';
import 'package:payflow_hive/shared/models/boleto_model.dart';
import 'package:payflow_hive/shared/theme.dart';
import 'package:payflow_hive/shared/widgets/buttons/icon_label_button.dart';
import 'package:payflow_hive/shared/widgets/buttons/button_outline.dart';

class BoletoBottomSheet extends StatelessWidget {
  final BoletoController controllerBoleto;
  final BoletoController controllerExtrato;
  final BoletoModel model;
  const BoletoBottomSheet({
    required this.model,
    required this.controllerBoleto,
    required this.controllerExtrato,
  });

  @override
  Widget build(BuildContext context) {
    String value = MoneyMaskedTextController(initialValue: model.value!).text;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          Container(
            color: AppColors.background,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 22),
                  child: Text.rich(
                    TextSpan(
                      text: 'O boleto ',
                      style: TextStyles.titleHeading,
                      children: [
                        TextSpan(
                          text: model.name,
                          style: TextStyles.titleBoldHeading,
                        ),
                        TextSpan(
                          text: " no valor de R\$ ",
                          style: TextStyles.titleHeading,
                        ),
                        TextSpan(
                          text: value,
                          style: TextStyles.titleBoldHeading,
                        ),
                        TextSpan(
                          text: ' foi pago ?',
                          style: TextStyles.titleHeading,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonOutline(
                        child: Text(
                          "Ainda não",
                          style: TextStyles.buttonGray,
                        ),
                        onTap: () {
                          controllerBoleto.boleto = BoletoModel();
                        },
                        borderColor: AppColors.stroke,
                        color: AppColors.shape,
                        padding: EdgeInsets.symmetric(
                          horizontal: 64,
                          vertical: 18,
                        ),
                      ),
                      ButtonOutline(
                        child: Text(
                          "Sim",
                          style: TextStyles.buttonBackground,
                        ),
                        onTap: () async {
                          await controllerBoleto.payBoleto();
                          await controllerBoleto.getBoletos();
                          await controllerExtrato.getExtratos();
                          controllerBoleto.boleto = BoletoModel();
                        },
                        padding: EdgeInsets.symmetric(
                          horizontal: 64,
                          vertical: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.stroke,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconLabelButton(
                        label: 'Deletar boleto',
                        style: TextStyles.buttonDelete,
                        onTap: () async {
                          await controllerBoleto.deleteBoleto();
                          controllerBoleto.boleto = BoletoModel();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.delete,
                        ),
                      ),
                      IconLabelButton(
                        label: 'Editar boleto',
                        style: TextStyles.buttonPrimary,
                        onTap: () async {
                          Navigator.pushNamed(context, '/insert_boleto',
                              arguments: [
                                model,
                                controllerBoleto,
                              ]);
                          controllerBoleto.boleto = BoletoModel();
                        },
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
