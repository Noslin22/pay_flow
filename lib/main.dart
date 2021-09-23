import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payflow_hive/pages/splash_page.dart';
import 'apps/app_firebase.dart';
import 'shared/models/boleto_model.dart';
import 'shared/models/user_model.dart';
import 'shared/theme.dart';

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

void notificationInit() async {
  await AwesomeNotifications().initialize('resource://drawable/res_logofull', [
    NotificationChannel(
      channelKey: 'scheduled_channel',
      channelName: 'Notificações Programadas',
      defaultColor: AppColors.primary,
      locked: true,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
  ]);
  AwesomeNotifications().actionStream.listen((notification) {
    if (notification.channelKey == 'scheduled_channel' && Platform.isIOS) {
      AwesomeNotifications().getGlobalBadgeCounter().then(
            (value) => AwesomeNotifications().setGlobalBadgeCounter(value - 1),
          );
    }
    StatefulBuilder(
      builder: (context, _) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => SplashPage(),
            ),
            (route) => route.isFirst);
        return Container();
      },
    );
  });
}
