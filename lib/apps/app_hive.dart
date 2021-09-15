import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:payflow_hive/shared/models/boleto_model.dart';
import 'package:payflow_hive/shared/models/user_model.dart';
import 'app_widget.dart';

class AppHive extends StatefulWidget {
  const AppHive({Key? key}) : super(key: key);

  @override
  _AppHiveState createState() => _AppHiveState();
}

class _AppHiveState extends State<AppHive> {
  Future<List<Box>> openBoxes() async => Future.value([
        await Hive.openBox<UserModel>("user"),
        await Hive.openBox<BoletoModel>("boletos"),
        await Hive.openBox<BoletoModel>("extratos"),
      ]);

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Box>>(
      future: openBoxes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Center(
                child: Text(
                  "Ocorreu um erro, tente mais tarde.",
                  textDirection: TextDirection.ltr,
                ),
              ),
            );
          } else {
            return AppWidget();
          }
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(),
          );
        }
      },
    );
  }
}
