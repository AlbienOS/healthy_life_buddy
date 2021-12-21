
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthy_life_buddy/common/navigation_notif.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';
import 'package:rxdart/rxdart.dart';

final selectNotifSubject = BehaviorSubject<String>();

class NotifHelper{
  static NotifHelper? _instance;

  NotifHelper._internal(){
    _instance = this;
  }
  factory NotifHelper() => _instance ?? NotifHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          if (payload != null) {
            print('notification payload: ' + payload);
          }
          selectNotifSubject.add(payload ?? 'empty payload');
        });
  }
  Future<void> showNotif(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      SportsVeneu sport) async{
    var _channelId = "1";
    var _channelName = "HealthyLifeBuddy";
    var _channelDescription = "Jangan Lupa Datang yaa";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>PENGINGAT PESANAN</b>";
    var titleBooking = sport.name;

    await flutterLocalNotificationsPlugin.show(0, titleNotification, titleBooking,
        platformChannelSpecifics, payload: json.encode(sport.toJson()));
  }

  void configureSelectNotificationSubject(String route){
    selectNotifSubject.stream.listen((String payload) async{
      var data = SportsVeneu.fromJson(json.decode(payload));
      var sportBook = data.name;
      Navigation.intentWithData(route, sportBook);
    });
  }


}