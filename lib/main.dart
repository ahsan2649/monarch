import 'package:flutter/material.dart';
import 'package:monarch/screens/start_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
      darkTheme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark)),
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.light)),
      themeMode: ThemeMode.system,
    );
  }
}
