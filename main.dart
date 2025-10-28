import 'package:flutter/material.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(const ECTSClickerApp());
}

class ECTSClickerApp extends StatelessWidget {
  const ECTSClickerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECTS Clicker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF1a1a2e),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}