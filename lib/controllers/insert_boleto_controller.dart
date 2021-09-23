import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:payflow_hive/controllers/boleto_list_controller.dart';
import 'package:payflow_hive/shared/models/boleto_model.dart';
import 'package:payflow_hive/shared/notification.dart' as notif;
part 'insert_boleto_controller.g.dart';

class InsertBoletoController = _InsertBoletoController
    with _$InsertBoletoController;

abstract class _InsertBoletoController with Store {
  final formKey = GlobalKey<FormState>();
  final BoletoController controller;
  late BoletoModel editModel;

  @observable
  bool erro = false;
  BoletoModel model;

  _InsertBoletoController({
    required this.controller,
    required this.model,
  });

  String? validateName(String? value) => value == null || value.isEmpty
      ? "O nome não pode ser vazio"
      : erro
          ? "Um boleto já existe com este nome"
          : null;
  String? validateVencimento(String? value) =>
      value?.isEmpty ?? true ? "A data de vencimento não pode ser vazio" : null;
  String? validateValor(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  String? validateCodigo(String? value) =>
      value?.isEmpty ?? true ? "O código do boleto não pode ser vazio" : null;

  @action
  Future<bool> cadastrarBoleto() async {
    final form = formKey.currentState;
    final Box<BoletoModel> boletosBox = Hive.box<BoletoModel>('boletos');
    if (form!.validate()) {
      if (model.isEmpty) {
        if (boletosBox.containsKey(editModel.name)) {
          erro = true;
        }
        await saveBoleto();
      } else {
        if (model.name != editModel.name &&
            boletosBox.containsKey(editModel.name)) {
          erro = true;
        }
        await editBoleto();
      }
      notif.Notification().createAlarm(editModel);
      return true;
    } else {
      return false;
    }
  }

  @action
  Future<void> saveBoleto() async {
    final Box<BoletoModel> boletosBox = Hive.box<BoletoModel>('boletos');
    boletosBox.put(editModel.name, editModel);
    controller.type == 'boletos'
        ? controller.getBoletos()
        : controller.getExtratos();
    return;
  }

  @action
  Future<void> editBoleto() async {
    final Box<BoletoModel> boletosBox = Hive.box<BoletoModel>('boletos');
    if (model.name != editModel.name) {
      boletosBox.delete(model.name);
      boletosBox.put(editModel.name, editModel);
      controller.type == 'boletos'
          ? controller.getBoletos()
          : controller.getExtratos();
    } else {
      boletosBox.put(editModel.name, editModel);
      controller.type == 'boletos'
          ? controller.getBoletos()
          : controller.getExtratos();
    }
  }

  @action
  void onChanged({
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
  }) {
    editModel = BoletoModel(
      name: name ?? editModel.name,
      dueDate: dueDate ?? editModel.dueDate,
      value: value ?? editModel.value,
      barcode: barcode ?? editModel.barcode,
      email: controller.userEmail,
    );
  }
}
