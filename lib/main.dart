import 'package:flutter/material.dart';
import 'package:healthy_buddy/common/colors_style.dart';
import 'package:healthy_buddy/common/navigation.dart';
import 'package:healthy_buddy/model/sport_venues_data.dart';
import 'package:healthy_buddy/ui/booking_page.dart';
import 'package:healthy_buddy/ui/detail_page.dart';
import 'package:healthy_buddy/ui/sports_list_page.dart';
import 'package:healthy_buddy/ui/start_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HealthyLifeBuddy',
        theme: ThemeData(scaffoldBackgroundColor: backgroundColor),
        initialRoute: StartPage.routeName,
        routes: {
          StartPage.routeName: (context) => const StartPage(),
          Navigation.routeName: (context) => const Navigation(),
          SportsListPage.routeName: (context) => const SportsListPage(),
          DetailPage.routeName: (context) => DetailPage(
              sports: ModalRoute.of(context)?.settings.arguments
                  as SportsVenuesData),
          BookingPage.routeName: (context) => const BookingPage(),
        });
  }
}
