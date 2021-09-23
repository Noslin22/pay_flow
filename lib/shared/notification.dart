import 'package:awesome_notifications/awesome_notifications.dart';

import 'models/boleto_model.dart';

class Notification {
  int _createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  Future<void> createAlarm(BoletoModel boleto) async {
    // List<int> date =
    //     boleto.dueDate!.split('/').map((e) => int.parse(e)).toList();
    DateTime date = DateTime.now();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _createUniqueId(),
        channelKey: 'scheduled_channel',
        title: 'O boleto ${boleto.name} está perto de vencer',
        body: 'Pague antes do dia ${date.day}',
        notificationLayout: NotificationLayout.Default,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'PAY',
          label: 'Pagar Boleto',
        )
      ],
      // schedule: NotificationCalendar(
      //   hour: 10,
      //   day: date[0] - 1,
      //   month: date[1],
      //   year: date[2],
      //   timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      // ),
      schedule: NotificationCalendar(
        year: date.year,
        month: date.month,
        day: date.day,
        hour: date.hour,
        minute: date.minute,
        second: date.second + 3,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      ),
    );
  }
}
