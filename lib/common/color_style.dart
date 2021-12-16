import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/text_style.dart';

const primaryColor = Color.fromRGBO(57, 174, 214, 1);
const primaryVariantColor = Color.fromRGBO(0, 126, 164, 1);
const backgroundColor = Color.fromRGBO(242, 246, 248, 1);
const surfaceColor = Color.fromRGBO(255, 255, 255, 1);
const errorColor = Color.fromRGBO(242, 49, 49, 1);
const onPrimaryColor = Color.fromRGBO(255, 255, 255, 1);
const onPrimaryVariantColor = Color.fromRGBO(255, 255, 255, 1);
const onBackgroundColor = Color.fromRGBO(26, 26, 26, 1);
const onSurfaceColor = Color.fromRGBO(26, 26, 26, 1);
const onErrorColor = Color.fromRGBO(255, 255, 255, 1);

ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: textTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
    ),
    cardColor: surfaceColor,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            textStyle: TextStyle(color: Colors.purple))));

const primaryColorDarkMode = Color.fromRGBO(57, 174, 214, 1);
const primaryVariantColorDarkMode = Color.fromRGBO(0, 126, 164, 1);
const backgroundColorDarkMode = Color.fromRGBO(54, 54, 54, 1);
const surfaceColorDarkMode = Color.fromRGBO(77, 77, 77, 1);
const errorColorDarkMode = Color.fromRGBO(242, 49, 49, 1);
const onPrimaryColorDarkMode = Color.fromRGBO(255, 255, 255, 1);
const onPrimaryVariantColorDarkMode = Color.fromRGBO(255, 255, 255, 1);
const onBackgroundColorDarkMode = Color.fromRGBO(26, 26, 26, 1);
const onSurfaceColorDarkMode = Color.fromRGBO(26, 26, 26, 1);
const onErrorColorDarkMode = Color.fromRGBO(255, 255, 255, 1);

ThemeData darkTheme = ThemeData(
  primaryColor: primaryColorDarkMode,
  scaffoldBackgroundColor: backgroundColorDarkMode,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: textThemeDarkTheme,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: surfaceColorDarkMode,
    selectedItemColor: primaryColor,
    unselectedIconTheme: IconThemeData(color: Colors.grey),
  ),
  cardColor: surfaceColorDarkMode,
);
