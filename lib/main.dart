import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // theme: ThemeData.light(useMaterial3: true),
        theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
            colorScheme: const ColorScheme.light()),
        debugShowCheckedModeBanner: false,
        home: const MainScreen());
  }
}
