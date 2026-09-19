import 'package:flutter/material.dart';

import 'screens/scoring_screen.dart';

void main() {
  runApp(const PencakSilatApp());
}

class PencakSilatApp extends StatelessWidget {
  const PencakSilatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pencak Silat Tanding',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const ScoringScreen(
        redFighter: 'RED',
        blueFighter: 'BLUE',
      ),
    );
  }
}
