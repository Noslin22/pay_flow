import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow_mobx/pages/Barcode/barcode_status.dart';

import 'package:mobx/mobx.dart';
part 'barcode_controller.g.dart';

class BarcodeController = _BarcodeController with _$BarcodeController;

abstract class _BarcodeController with Store {
  @observable
  BarcodeStatus status = BarcodeStatus();

  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  InputImage? imagePicker;
  CameraController? cameraController;
  
  @action
  Future<void> getAvailableCameras() async {
    try {
      final response = await availableCameras();
      final camera = response.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back,
      );
      cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );
      await cameraController!.initialize();
      scanWithCamera();
      listenCamera();
    } catch (e) {
      status = BarcodeStatus.error(e.toString());
    }
  }

  void scanWithImagePicker() async {
    XFile? response =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);
    scannerBarcode(inputImage);
  }

  void listenCamera() {
    if (cameraController!.value.isStreamingImages == false)
      cameraController!.startImageStream(
        (cameraImage) async {
          if (status.stopScanner == false) {
            try {
              final WriteBuffer allBytes = WriteBuffer();
              for (Plane plane in cameraImage.planes) {
                allBytes.putUint8List(plane.bytes);
              }
              final bytes = allBytes.done().buffer.asUint8List();

              final Size imageSize = Size(
                cameraImage.width.toDouble(),
                cameraImage.height.toDouble(),
              );

              final InputImageRotation imageRotation =
                  InputImageRotationMethods.fromRawValue(
                        cameraImage.format.raw,
                      ) ??
                      InputImageRotation.Rotation_0deg;

              final InputImageFormat inputImageFormat =
                  InputImageFormatMethods.fromRawValue(
                          cameraImage.format.raw) ??
                      InputImageFormat.NV21;

              final planeData = cameraImage.planes.map(
                (Plane plane) {
                  return InputImagePlaneMetadata(
                    bytesPerRow: plane.bytesPerRow,
                    height: plane.height,
                    width: plane.width,
                  );
                },
              ).toList();

              final inputImageData = InputImageData(
                size: imageSize,
                imageRotation: imageRotation,
                inputImageFormat: inputImageFormat,
                planeData: planeData,
              );

              final inputImageCamera = InputImage.fromBytes(
                bytes: bytes,
                inputImageData: inputImageData,
              );
              scannerBarcode(inputImageCamera);
            } catch (e) {
              print(e);
            }
          }
        },
      );
  }
  
  @action
  Future<void> scannerBarcode(InputImage inputImage) async {
    try {
      final barcodes = await barcodeScanner.processImage(inputImage);
      String? barcode;
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }

      if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeStatus.barcode(barcode);
        cameraController!.dispose();
        await barcodeScanner.close();
      }
      return;
    } catch (e) {
      print("Erro na leitura: $e");
    }
  }
  
  @action
  void scanWithCamera() {
    status = BarcodeStatus.available();
    Future.delayed(Duration(seconds: 10)).then(
      (value) {
        if (status.hasBarcode == false)
          status = BarcodeStatus.error('Timeout da leitura do boleto');
      },
    );
  }

  void dispose() {
    if (status.showCamera) {
      cameraController!.dispose();
    }
    barcodeScanner.close();
  }
}
