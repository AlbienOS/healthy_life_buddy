import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/helper/navigation.dart';
import 'package:healthy_life_buddy/interface/detail_sports_revenue_page.dart';
import 'package:healthy_life_buddy/interface/home_page.dart';
import 'package:healthy_life_buddy/interface/welcome_page.dart';
import 'package:healthy_life_buddy/provider/sports_venue_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SportsVenueProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthyLifeBuddy',
      theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
      initialRoute: WelcomePage.routeName,
      routes: {
        WelcomePage.routeName: (context) => const WelcomePage(),
        Navigation.routeName: (context) => const Navigation(),
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
