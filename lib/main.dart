import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  // Configura o SQLite para rodar no Windows
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const StudyPlannerApp()); // Sua linha original do app
}


class StudyPlannerApp extends StatefulWidget {
  const StudyPlannerApp({super.key});

  static StudyPlannerAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<
        StudyPlannerAppState>();
  }

  @override
  State<StudyPlannerApp> createState() =>
      StudyPlannerAppState();
}

class StudyPlannerAppState
    extends State<StudyPlannerApp> {

  bool darkMode = false;

  void toggleTheme(bool value) {
    setState(() {
      darkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Study Planner',

      themeMode:
          darkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),

      home: const HomeScreen(),
    );
  }
}