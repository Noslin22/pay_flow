// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boleto_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BoletoController on _BoletoController, Store {
  final _$boletosAtom = Atom(name: '_BoletoController.boletos');

  @override
  List<BoletoModel> get boletos {
    _$boletosAtom.reportRead();
    return super.boletos;
  }

  @override
  set boletos(List<BoletoModel> value) {
    _$boletosAtom.reportWrite(value, super.boletos, () {
      super.boletos = value;
    });
  }

  final _$boletoAtom = Atom(name: '_BoletoController.boleto');

  @override
  BoletoModel get boleto {
    _$boletoAtom.reportRead();
    return super.boleto;
  }

  @override
  set boleto(BoletoModel value) {
    _$boletoAtom.reportWrite(value, super.boleto, () {
      super.boleto = value;
    });
  }

  final _$getBoletosAsyncAction = AsyncAction('_BoletoController.getBoletos');

  @override
  Future<void> getBoletos() {
    return _$getBoletosAsyncAction.run(() => super.getBoletos());
  }

  final _$getExtratosAsyncAction = AsyncAction('_BoletoController.getExtratos');

  @override
  Future<void> getExtratos() {
    return _$getExtratosAsyncAction.run(() => super.getExtratos());
  }

  final _$deleteBoletoAsyncAction =
      AsyncAction('_BoletoController.deleteBoleto');

  @override
  Future<void> deleteBoleto() {
    return _$deleteBoletoAsyncAction.run(() => super.deleteBoleto());
  }

  @override
  String toString() {
    return '''
boletos: ${boletos},
boleto: ${boleto}
    ''';
  }
}
