import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/helper/navigation_helper.dart';
import 'package:healthy_life_buddy/helper/preferences_helper.dart';
import 'package:healthy_life_buddy/interface/booking_sports_venue_page.dart';
import 'package:healthy_life_buddy/interface/detail_sports_venue_page.dart';
import 'package:healthy_life_buddy/interface/home_page.dart';
import 'package:healthy_life_buddy/interface/login_page.dart';
import 'package:healthy_life_buddy/interface/member_sports_page.dart';
import 'package:healthy_life_buddy/interface/welcome_page.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';
import 'package:healthy_life_buddy/model/sports_venue_model.dart';
import 'package:healthy_life_buddy/provider/favorite_sports_venue_provider.dart';
import 'package:healthy_life_buddy/provider/preferences_provider.dart';
import 'package:healthy_life_buddy/provider/sports_venue_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return ChangeNotifierProvider<PreferencesProvider>(
      create: (context) => PreferencesProvider(
          preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance())),
      child: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return MaterialApp(
          title: 'HealthyLifeBuddy',
          theme: provider.themeData,
          initialRoute: LoginPage.routeName,
          routes: {
            WelcomePage.routeName: (context) => const WelcomePage(),
            LoginPage.routeName: (context) => const LoginPage(),
            Navigation.routeName: (context) => const Navigation(),
            HomePage.routeName: (context) => const HomePage(),
            DetailSportsVenuePage.routeName: (context) => DetailSportsVenuePage(
                sportsVenueId:
                    ModalRoute.of(context)?.settings.arguments as String),
            BookingSportsVenuePage.routeName: (context) =>
                BookingSportsVenuePage(
                    sportsVenueData: ModalRoute.of(context)?.settings.arguments
                        as DetailSportsVeneu),
          },
        );
      }),
    );
  }
}
