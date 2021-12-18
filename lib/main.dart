import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/helper/navigation.dart';
import 'package:healthy_life_buddy/interface/booking_sports_venue_page.dart';
import 'package:healthy_life_buddy/interface/detail_sports_venue_page.dart';
import 'package:healthy_life_buddy/interface/home_page.dart';
import 'package:healthy_life_buddy/interface/login_page.dart';
import 'package:healthy_life_buddy/interface/welcome_page.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:healthy_life_buddy/provider/favorite_sports_venue_provider.dart';
import 'package:healthy_life_buddy/utils/background_service.dart';
import 'package:healthy_life_buddy/utils/notif_helper.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  // final NotificationHelper _notificationHelper = NotificationHelper();
  // final BackgroundService _service = BackgroundService();
  // _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  // await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<FavoriteSportsVeneuProvider>(
      create: (context) => FavoriteSportsVeneuProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthyLifeBuddy',
      theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
      initialRoute: LoginPage.routeName,
      routes: {
        WelcomePage.routeName: (context) => const WelcomePage(),
        LoginPage.routeName: (context) => const LoginPage(),
        Navigation.routeName: (context) => const Navigation(),
        HomePage.routeName: (context) => const HomePage(),
        DetailSportsVenuePage.routeName: (context) => DetailSportsVenuePage(
            sportsVenueId:
                ModalRoute.of(context)?.settings.arguments as String),
        BookingSportsVenuePage.routeName: (context) => BookingSportsVenuePage(
            sportsVenueData:
                ModalRoute.of(context)?.settings.arguments as DetailSportsVeneu),
      },
    );
  }
}
