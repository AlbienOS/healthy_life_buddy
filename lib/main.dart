import 'package:flutter/material.dart';
import 'package:healthy_buddy/ui/start_page.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthyBuddy',
      theme: ThemeData(),
      home: StartPage(),
    );
  }

}