import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import 'package:payflow_hive/controllers/barcode_controller.dart';
import 'package:payflow_hive/controllers/boleto_list_controller.dart';
import 'package:payflow_hive/shared/models/boleto_model.dart';
import 'package:payflow_hive/shared/theme.dart';
import 'package:payflow_hive/shared/widgets/bottom_sheet/barcode_bottom_sheet.dart';
import 'package:payflow_hive/shared/widgets/buttons/set_label_buttons.dart';

class BarcodeScannerPage extends StatefulWidget {
  final BoletoController controller;
  const BarcodeScannerPage({
    required this.controller,
  });
  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeController();

  @override
  void initState() {
    controller.getAvailableCameras();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reaction((_) => controller.status, (status) {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, '/insert_boleto', arguments: [
          BoletoModel(barcode: controller.status.barcode),
          widget.controller,
        ]);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Observer(
              builder: (_) {
                if (controller.status.showCamera) {
                  return Container(
                    child: controller.cameraController!.buildPreview(),
                  );
                } else {
                  return Container();
                }
              },
            ),
            RotatedBox(
              quarterTurns:
                  constraints.minHeight > constraints.minWidth ? 1 : 0,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(
                    'Escaneie o código de barras do boleto',
                    style: TextStyles.buttonBackground,
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.black,
                  leading: BackButton(
                    color: AppColors.background,
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.black.withOpacity(0.85),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: SetLabelButtons(
                  primaryLabel: "Inserir código do boleto",
                  primaryOnTap: () {
                    Navigator.pushReplacementNamed(context, '/insert_boleto',
                        arguments: [
                          null,
                          widget.controller,
                        ]);
                  },
                  secondaryLabel: 'Adicionar da galeria',
                  secondaryOnTap: () {
                    controller.scanWithImagePicker();
                  },
                ),
              ),
            ),
            Observer(
              builder: (_) {
                if (controller.status.hasError) {
                  return BarcodeBottomSheet(
                    title: kIsWeb
                        ? 'A opção de escanear não está disponivel no site.'
                        : 'Não foi possível identificar um código de barras.',
                    subtitle: kIsWeb
                        ? 'Tente no nosso app para dispositivos móveis ou digite o código manualmente.'
                        : 'Tente escanear novamente ou digite o código do seu boleto.',
                    primaryLabel: kIsWeb ? 'Cancelar' : 'Escanear novamente',
                    primaryOnTap: () {
                      if (kIsWeb) {
                        Navigator.pop(context);
                      } else {
                        controller.scanWithCamera();
                      }
                    },
                    secondaryLabel: 'Digitar código',
                    secondaryOnTap: () {
                      Navigator.pushReplacementNamed(context, '/insert_boleto',
                          arguments: [
                            null,
                            widget.controller,
                          ]);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        );
      }),
    );
  }
}
