// lib/main.dart
import 'package:faculdadeextensao/core/constants.dart';
import 'package:faculdadeextensao/modules/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:faculdadeextensao/modules/home/notifier/notifier.dart'; // Adjust import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShowListViewModel(), // Assuming this is your ViewModel
      child: MaterialApp(
        title: 'Teatro Comunitario Bela Vista',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: gray900, // Base background
          primaryColor: rose600,
          hintColor: rose400, // Accent color
          textTheme: ThemeData.dark().textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: rose600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              textStyle: buttonTextStyle,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              textStyle: buttonTextStyle,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          dialogTheme: DialogTheme(
            backgroundColor: gray800,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            titleTextStyle:
                headline2Style.copyWith(fontSize: 22, color: Colors.white),
            contentTextStyle: bodyTextStyle.copyWith(color: gray400),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: gray700,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: gray600),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: gray600),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: rose600),
            ),
            labelStyle: TextStyle(color: gray300),
            hintStyle: TextStyle(color: gray400),
          ),
          cardTheme: CardTheme(
            color: gray800,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: gray700),
            ),
            margin: EdgeInsets.zero,
          ),
        ),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
