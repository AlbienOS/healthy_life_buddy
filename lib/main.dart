import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthy_life_buddy/helper/navigation_helper.dart';
import 'package:healthy_life_buddy/helper/preferences_helper.dart';
import 'package:healthy_life_buddy/interface/booking_sports_venue_page.dart';
import 'package:healthy_life_buddy/interface/detail_sports_venue_page.dart';
import 'package:healthy_life_buddy/interface/home_page.dart';
import 'package:healthy_life_buddy/interface/login_page.dart';
import 'package:healthy_life_buddy/interface/member_sports_page.dart';
import 'package:healthy_life_buddy/interface/registration_page.dart';
import 'package:healthy_life_buddy/interface/user_data_registration_page.dart';
import 'package:healthy_life_buddy/interface/welcome_page.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:healthy_life_buddy/provider/article_provider.dart';
import 'package:healthy_life_buddy/provider/auth_provider.dart';
import 'package:healthy_life_buddy/provider/booking_provider.dart';
import 'package:healthy_life_buddy/provider/favorite_sports_venue_provider.dart';
import 'package:healthy_life_buddy/provider/preferences_provider.dart';
import 'package:healthy_life_buddy/utils/background_service.dart';
import 'package:healthy_life_buddy/utils/notif_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final NotifHelper _notifHelper = NotifHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notifHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<FavoriteSportsVeneuProvider>(
          create: (context) => FavoriteSportsVeneuProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ArticleProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          title: 'HealthyLifeBuddy',
          theme: provider.themeData,
          initialRoute: LoginPage.routeName,
          routes: {
            WelcomePage.routeName: (context) => const WelcomePage(),
            LoginPage.routeName: (context) => const LoginPage(),
            Navigation.routeName: (context) => const Navigation(),
            HomePage.routeName: (context) => const HomePage(),
            RegistrationPage.routeName: (context) => const RegistrationPage(),
            UserDataRegistrationPage.routeName: (context) =>
                const UserDataRegistrationPage(),
            DetailSportsVenuePage.routeName: (context) => DetailSportsVenuePage(
                sportsVenueId:
                    ModalRoute.of(context)?.settings.arguments as String),
            BookingSportsVenuePage.routeName: (context) =>
                BookingSportsVenuePage(
                    sportsVenueData: ModalRoute.of(context)?.settings.arguments
                        as DetailSportsVeneu),
            MemberPage.routeName: (context) => MemberPage(
                sportsVenueData: ModalRoute.of(context)?.settings.arguments
                    as DetailSportsVeneu),
          },
        );
      },
    );
  }
}
