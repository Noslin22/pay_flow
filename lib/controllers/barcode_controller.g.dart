// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BarcodeController on _BarcodeController, Store {
  final _$statusAtom = Atom(name: '_BarcodeController.status');

  @override
  BarcodeStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(BarcodeStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$getAvailableCamerasAsyncAction =
      AsyncAction('_BarcodeController.getAvailableCameras');

  @override
  Future<void> getAvailableCameras() {
    return _$getAvailableCamerasAsyncAction
        .run(() => super.getAvailableCameras());
  }

  final _$scannerBarcodeAsyncAction =
      AsyncAction('_BarcodeController.scannerBarcode');

  @override
  Future<void> scannerBarcode(InputImage inputImage) {
    return _$scannerBarcodeAsyncAction
        .run(() => super.scannerBarcode(inputImage));
  }

  final _$_BarcodeControllerActionController =
      ActionController(name: '_BarcodeController');

  @override
  void scanWithCamera() {
    final _$actionInfo = _$_BarcodeControllerActionController.startAction(
        name: '_BarcodeController.scanWithCamera');
    try {
      return super.scanWithCamera();
    } finally {
      _$_BarcodeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status}
    ''';
  }
}
