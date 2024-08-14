import 'dart:ui';
import 'package:flutter/widgets.dart';

bool isDarkTheme(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  bool isDarkMode = brightness == Brightness.dark;
  return isDarkMode;
}