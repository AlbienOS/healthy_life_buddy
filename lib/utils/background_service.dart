import 'dart:isolate';

import 'dart:ui';

import 'package:healthy_life_buddy/api/sports_venue_api.dart';
import 'package:healthy_life_buddy/utils/notif_helper.dart';

import '../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotifHelper _notificationHelper = NotifHelper();
    var result = await getSportsVenue();
    await _notificationHelper.showNotif(
        flutterLocalNotificationsPlugin, result[0]);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}