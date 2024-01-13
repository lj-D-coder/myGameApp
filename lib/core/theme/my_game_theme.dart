import 'package:flutter/material.dart';

final myGameThemeLight = ThemeData(
  useMaterial3: true,
  primaryColor: const Color(0xff2C3444),
  textTheme: const TextTheme(
      displayLarge: TextStyle(),
      displayMedium: TextStyle(),
      displaySmall: TextStyle(),
      bodySmall: TextStyle(),
      bodyMedium: TextStyle(),
      bodyLarge: TextStyle(),
      labelLarge: TextStyle(),
      labelMedium: TextStyle(),
      labelSmall: TextStyle()
    ).apply(
      bodyColor: Colors.white, 
      displayColor: Colors.white, 
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: const Color(0xff2C3444),
    showSelectedLabels: true,
    elevation: 0,
    selectedIconTheme: IconThemeData(color: Colors.white),
    selectedItemColor: Colors.white,
    unselectedIconTheme: IconThemeData(color: Colors.grey.shade700),
    unselectedItemColor: Colors.grey.shade500,
    selectedLabelStyle:  TextStyle(color: Colors.white),
    unselectedLabelStyle: TextStyle(color: Colors.grey.shade700)
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.white,
    titleTextStyle: TextStyle(color: Colors.white,fontSize: 15),
    subtitleTextStyle: TextStyle(color: Colors.grey,fontSize: 12)
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme:  const AppBarTheme(
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white),
    iconTheme: IconThemeData(
     size: 30,
     color: Colors.white 
    ),
    backgroundColor: Color(0xff2C3444)
  )
);