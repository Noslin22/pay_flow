import 'package:mobx/mobx.dart';
import 'package:payflow_mobx/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'boleto_list_controller.g.dart';

class BoletoController = _BoletoController with _$BoletoController;

abstract class _BoletoController with Store {
  @observable
  List<BoletoModel> boletos = [];
  @observable
  BoletoModel boleto = BoletoModel();

  String userEmail = '';
  String type = '';

  _BoletoController.boleto({required String email}) {
    getBoletos();
    type = 'boletos';
    userEmail = email;
  }
  _BoletoController.extrato({required String email}) {
    getExtratos();
    type = 'extratos';
    userEmail = email;
  }

  @action
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

  @action
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

  @action
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
