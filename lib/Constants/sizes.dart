import 'package:flutter/material.dart';


// Dynamic screen width
double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

// Dynamic screen height
double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

// Dynamic text size
double textSize(BuildContext context) {
  return MediaQuery.of(context).textScaleFactor;
}