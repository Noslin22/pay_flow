import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'apps/app_firebase.dart';
import 'shared/models/boleto_model.dart';
import 'shared/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  Hive
    ..registerAdapter(UserModelAdapter())
    ..registerAdapter(BoletoModelAdapter());
  runApp(AppFirebase());
}
