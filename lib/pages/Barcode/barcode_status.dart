class BarcodeStatus {
  final bool isCameraAvailable;
  final String error;
  final String barcode;
  final bool stopScanner;

  BarcodeStatus({
    this.isCameraAvailable = false,
    this.error = '',
    this.stopScanner = false,
    this.barcode = '',
  });

  factory BarcodeStatus.available() => BarcodeStatus(
        isCameraAvailable: true,
        stopScanner: false,
      );

  factory BarcodeStatus.error(String error) =>
      BarcodeStatus(error: error, stopScanner: true);

  factory BarcodeStatus.barcode(String barcode) =>
      BarcodeStatus(barcode: barcode, stopScanner: true);

  bool get showCamera => isCameraAvailable && error.isEmpty;
  bool get hasError => error.isNotEmpty;
  bool get hasBarcode => barcode.isNotEmpty;
}
