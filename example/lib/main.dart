import 'package:flutter/material.dart';

import 'page/common.dart';
import 'page/home.dart';
import 'page/use.dart';
import 'page/wave.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => const HomePage(),
        "/common": (context) => const CommonPage(),
        "/wave": (context) => const WavePage(),
        "/use": (context) => const UsePage(),
      },
      home: const HomePage(),
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 10,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            color: Colors.blue,
            fontSize: 11,
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
