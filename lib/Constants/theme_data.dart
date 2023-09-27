import 'package:flutter/material.dart';



//Constants
String fontFamily = "nunito";
const Color primaryColor = Color(0xffAB081B);
const Color buttonColor = Color(0xff700713);
//
//
// Light theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  iconTheme: const IconThemeData(color: Colors.black),
  fontFamily: fontFamily,
  primaryColor: const Color(0xffAB081B),
  cardColor: const Color(0XFFF6F7F9),
  textTheme: const TextTheme(

    displayLarge:   TextStyle(
        fontWeight: FontWeight.bold, fontSize: 30),

    displayMedium:  TextStyle(
      fontSize: 14.0, fontWeight: FontWeight.w500,
      color: Colors.black),

    //custom textField
    displaySmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),

    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),

    bodyMedium: TextStyle(
      fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),

    bodyLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),

    titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),

    titleMedium: TextStyle(
      fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black),

    labelSmall: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),

    // titleLarge: TextStyle(
    //     fontSize: 30,
    //     fontFamily: fontFamily,
    //     fontWeight: FontWeight.w900,
    //     color: txtColor),
    //
    // labelSmall: TextStyle(
    //     fontSize: 11,
    //     fontFamily: fontFamily,
    //     fontWeight: FontWeight.w400,
    //     color: txtColor),
    //
    // labelMedium: TextStyle(
    //   fontSize: 14,
    //   fontWeight: FontWeight.w600,
    //   color: txtColor,
    //   fontFamily: fontFamily,
    // ),
    //
    // labelLarge: TextStyle(
    //   fontSize: 16,
    //   fontWeight: FontWeight.w700,
    //   color: txtColor,
    //   fontFamily: fontFamily,
    // ),
    //
    // headlineSmall: TextStyle(
    //   fontSize: 11,
    //   fontWeight: FontWeight.w500,
    //   color: txtColor,
    //   fontFamily: fontFamily,
    // ),
    //
    // headlineMedium: TextStyle(
    //   fontSize: 20,
    //   fontWeight: FontWeight.w700,
    //   color: txtColor,
    //   fontFamily: fontFamily,
    // ),
    //
    // headlineLarge: TextStyle(
    //   fontSize: 24,
    //   fontWeight: FontWeight.w800,
    //   color: Colors.black,
    //   fontFamily: fontFamily,
    // ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(primaryColor),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(vertical: 12),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
);