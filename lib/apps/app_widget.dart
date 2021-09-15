import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow_hive/controllers/boleto_list_controller.dart';
import 'package:payflow_hive/pages/Barcode/barcode_scanner_page.dart';
import 'package:payflow_hive/pages/home_page.dart';
import 'package:payflow_hive/pages/insert_boleto_page.dart';
import 'package:payflow_hive/pages/login_page.dart';
import 'package:payflow_hive/pages/splash_page.dart';
import 'package:payflow_hive/shared/models/boleto_model.dart';
import 'package:payflow_hive/shared/theme.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        primarySwatch: Colors.orange,
      ),
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/barcode_scanner': (context) {
          return BarcodeScannerPage(
            controller:
                ModalRoute.of(context)!.settings.arguments as BoletoController,
          );
        },
        '/insert_boleto': (context) {
          List<dynamic> args =
              ModalRoute.of(context)!.settings.arguments as List<dynamic>;
          return InsertBoletoPage(
            model: args[0] != null ? args[0] as BoletoModel : BoletoModel(),
            boletoController: args[1] as BoletoController,
          );
        },
        '/': (context) => SplashPage(),
      },
      initialRoute: '/',
    );
  }
}
