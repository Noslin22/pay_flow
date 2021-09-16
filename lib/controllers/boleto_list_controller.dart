import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:payflow_hive/shared/models/boleto_model.dart';
part 'boleto_list_controller.g.dart';

class BoletoController = BoletoControllerBase with _$BoletoController;

abstract class BoletoControllerBase with Store {
  @observable
  List<BoletoModel> boletos = [];
  @observable
  BoletoModel boleto = BoletoModel();

  String userEmail = '';
  String type = '';

  BoletoControllerBase.boleto({required String email}) {
    userEmail = email;
    type = 'boletos';
    getBoletos();
  }
  BoletoControllerBase.extrato({required String email}) {
    userEmail = email;
    type = 'extratos';
    getExtratos();
  }

  @action
  Future<void> getBoletos() async {
    try {
      final Box<BoletoModel> boletosBox = Hive.box<BoletoModel>('boletos');
      final response = boletosBox.values;
      boletos =
          response.where((element) => element.email == userEmail).toList();
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }

  @action
  Future<void> getExtratos() async {
    try {
      final Box<BoletoModel> extratosBox = Hive.box<BoletoModel>('extratos');
      final response = extratosBox.values;
      boletos =
          response.where((element) => element.email == userEmail).toList();
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }

  @action
  Future<void> payBoleto() async {
    final Box<BoletoModel> boletosBox = Hive.box<BoletoModel>('boletos');
    final Box<BoletoModel> extratosBox = Hive.box<BoletoModel>('extratos');
    boletosBox.delete(boleto.name);
    extratosBox.put(boleto.name, boleto);
    return;
  }

  @action
  Future<void> deleteBoleto() async {
    final Box<BoletoModel> boletosBox = Hive.box('boletos');
    boletosBox.delete(boleto.name);
    getBoletos();
    return;
  }

  @action
  Future<void> deleteExtrato() async {
    final Box<BoletoModel> extratosBox = Hive.box('extratos');
    extratosBox.delete(boleto.name);
    getExtratos();
    return;
  }
}
