
import 'package:healthy_life_buddy/main.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:convert';
import 'package:healthy_life_buddy/helper/navigation_data_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthy_life_buddy/helper/navigation_data_notification.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationHelper{
  static final _notif = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static Future _notificationDetails() async{
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max
      ),
    );
  }

  static Future init({bool initScheduled = false}) async{
    final android = AndroidInitializationSettings('app_icon');
    final settings = InitializationSettings(android: android);

    await _notif.initialize(
       settings,
       onSelectNotification: (payload) async{
         onNotification.add(payload);
       }
     );

    if(initScheduled){
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showScheduledNotify({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
}) async =>
    _notif.zonedSchedule(
        id,
        title,
        body,
        _scheduleDaily(Time(8)),
        await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  static tz.TZDateTime _scheduleDaily(Time time){
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days: 1))
        : scheduledDate;

  }

}

// final notificationSubject = BehaviorSubject<String>();
//
// class NotificationHelper {
//   static NotificationHelper? _instance;
//
//   NotificationHelper._internal(){
//     _instance = this;
//   }
//
//   factory NotificationHelper() => _instance ?? NotificationHelper._internal();
//
//   Future<void> initNotifications(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var initializationSettingsAndroid =
//     AndroidInitializationSettings('app_icon');
//
//
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//
//         onSelectNotification: (String? payload) async {
//           if (payload != null) {
//             print('notification payload: ' + payload);
//           }
//           notificationSubject.add(payload ?? 'empty payload');
//         });
//   }
//
//   Future<void> showNotification(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
//       SportsVeneu sport) async {
//     var _channelId = "1";
//     var _channelName = "channel_01";
//     //var _channelDescription = "dicoding news channel";
//
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         _channelId, _channelName,
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker',
//         styleInformation: DefaultStyleInformation(true, true));
//
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics);
//
//     var titleNotification = "<b>BOOKING REMINDER</b>";
//     var venueName = sport.name;
//
//     await flutterLocalNotificationsPlugin.show(0, titleNotification, venueName ,platformChannelSpecifics, payload: jsonEncode(sport.toMap()));
//   }
//
//
//
//
//
//   void configureSelectNotificationSubject(String route) {
//     notificationSubject.stream.listen((String payload) async {
//
//       var data = SportsVeneu.fromObject(jsonDecode(payload));
//       var sports = data.name;
//       Navigation.intentWithData(route, sports);
//     });
//   }
//
// }
