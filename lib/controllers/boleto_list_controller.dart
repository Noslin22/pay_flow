import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoController {
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  final boletoNotifier = ValueNotifier<BoletoModel>(BoletoModel());

  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;
  set boleto(BoletoModel value) => boletoNotifier.value = value;

  List<BoletoModel> get boletos => boletosNotifier.value;
  BoletoModel get boleto => boletoNotifier.value;

  String userEmail = '';
  String type = '';

  BoletoController.boleto({required String email}) {
    getBoletos();
    type = 'boletos';
    userEmail = email;
  }
  BoletoController.extrato({required String email}) {
    getExtratos();
    type = 'extratos';
    userEmail = email;
  }

  Future<void> getBoletos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final response = prefs.getStringList('boletos') ?? <String>[];
      boletos = response
          .map((e) => BoletoModel.fromJson(e))
          .where((element) => element.email == userEmail)
          .toList();
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }

  Future<void> getExtratos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final response = prefs.getStringList('extratos') ?? <String>[];
      boletos = response
          .map((e) => BoletoModel.fromJson(e))
          .where((element) => element.email == userEmail)
          .toList();
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }

  Future<void> payBoleto() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final extratos = prefs.getStringList('extratos') ?? <String>[];
    final boletos = prefs.getStringList('boletos') ?? <String>[];
    extratos.add(boleto.toJson());
    boletos.remove(boleto.toJson());
    await prefs.setStringList('extratos', extratos);
    await prefs.setStringList('boletos', boletos);
    type == 'boletos' ? getBoletos() : getExtratos();
    return;
  }

  Future<void> deleteBoleto() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final boletos = prefs.getStringList('boletos') ?? <String>[];
    boletos.remove(boleto.toJson());
    await prefs.setStringList('boletos', boletos);
    getBoletos();
    return;
  }

  Future<void> deleteExtrato() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final extratos = prefs.getStringList('extratos') ?? <String>[];
    extratos.remove(boleto.toJson());
    await prefs.setStringList('extratos', extratos);
    getExtratos();
    return;
  }
}
