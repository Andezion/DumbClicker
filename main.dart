import 'package:flutter/material.dart';
import 'ui/home_screen.dart';
import 'service/purchase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PurchaseService.initialize();

  runApp(const ECTSClickerApp());
}

class ECTSClickerApp extends StatelessWidget {
  const ECTSClickerApp({super.key});

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