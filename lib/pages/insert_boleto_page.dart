import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow_mobx/controllers/boleto_list_controller.dart';
import 'package:payflow_mobx/controllers/insert_boleto_controller.dart';
import 'package:payflow_mobx/shared/models/boleto_model.dart';

import 'package:payflow_mobx/shared/theme.dart';
import 'package:payflow_mobx/shared/widgets/input_text.dart';
import 'package:payflow_mobx/shared/widgets/buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final BoletoController boletoController;
  final BoletoModel model;
  const InsertBoletoPage({
    required this.boletoController,
    required this.model,
  });
  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  late final InsertBoletoController? controller;
  final moneyController = MoneyMaskedTextController(
    decimalSeparator: ',',
    leftSymbol: 'R\$',
    thousandSeparator: '.',
  );
  final dateController = MaskedTextController(mask: '00/00/0000');
  final barcodeController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    controller = InsertBoletoController(
        controller: widget.boletoController, model: widget.model);
    controller!.editModel = widget.model;
    if (widget.model != BoletoModel()) {
      nameController.text = widget.model.name ?? '';
      dateController.text = widget.model.dueDate ?? '';
      moneyController.updateValue(widget.model.value ?? 0);
      barcodeController.text = widget.model.barcode ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: BackButton(
          color: AppColors.input,
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 93,
                  vertical: 24,
                ),
                child: Text(
                  'Preencha os dados do boleto',
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: controller!.formKey,
                child: Column(
                  children: [
                    InputText(
                      label: 'Nome do boleto',
                      controller: nameController,
                      validator: controller!.validateName,
                      icon: Icons.description_outlined,
                      onChanged: (value) {
                        controller!.onChanged(name: value);
                      },
                    ),
                    InputText(
                      label: 'Vencimento',
                      controller: dateController,
                      validator: controller!.validateVencimento,
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) {
                        controller!.onChanged(dueDate: value);
                      },
                    ),
                    InputText(
                      label: 'Valor',
                      controller: moneyController,
                      validator: (_) => controller!
                          .validateValor(moneyController.numberValue),
                      icon: FontAwesomeIcons.wallet,
                      onChanged: (value) {
                        controller!.onChanged(
                          value: moneyController.numberValue,
                        );
                      },
                    ),
                    InputText(
                      label: 'Código',
                      controller: barcodeController,
                      validator: controller!.validateCodigo,
                      icon: FontAwesomeIcons.barcode,
                      onChanged: (value) {
                        controller!.onChanged(barcode: value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        primaryColor: 1,
        primaryLabel: 'Cancelar',
        secondaryLabel: 'Cadastrar',
        primaryOnTap: () {
          Navigator.pop(context);
        },
        secondaryOnTap: () async {
          if (widget.model != BoletoModel()) {
            controller!.editBoleto();
            Navigator.pop(context);
          } else if (await controller!.cadastrarBoleto()) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
