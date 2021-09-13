// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_boleto_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InsertBoletoController on _InsertBoletoController, Store {
  final _$erroAtom = Atom(name: '_InsertBoletoController.erro');

  @override
  bool get erro {
    _$erroAtom.reportRead();
    return super.erro;
  }

  @override
  set erro(bool value) {
    _$erroAtom.reportWrite(value, super.erro, () {
      super.erro = value;
    });
  }

  final _$cadastrarBoletoAsyncAction =
      AsyncAction('_InsertBoletoController.cadastrarBoleto');

  @override
  Future<bool> cadastrarBoleto() {
    return _$cadastrarBoletoAsyncAction.run(() => super.cadastrarBoleto());
  }

  final _$saveBoletoAsyncAction =
      AsyncAction('_InsertBoletoController.saveBoleto');

  @override
  Future<void> saveBoleto() {
    return _$saveBoletoAsyncAction.run(() => super.saveBoleto());
  }

  final _$editBoletoAsyncAction =
      AsyncAction('_InsertBoletoController.editBoleto');

  @override
  Future<void> editBoleto() {
    return _$editBoletoAsyncAction.run(() => super.editBoleto());
  }

  final _$_InsertBoletoControllerActionController =
      ActionController(name: '_InsertBoletoController');

  @override
  void onChanged(
      {String? name, String? dueDate, double? value, String? barcode}) {
    final _$actionInfo = _$_InsertBoletoControllerActionController.startAction(
        name: '_InsertBoletoController.onChanged');
    try {
      return super.onChanged(
          name: name, dueDate: dueDate, value: value, barcode: barcode);
    } finally {
      _$_InsertBoletoControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
erro: ${erro}
    ''';
  }
}
