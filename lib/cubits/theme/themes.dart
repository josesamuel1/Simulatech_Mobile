import 'package:flutter/material.dart';

// Cores padrões do sistema
const Color transparent = Color.fromRGBO(0, 0, 0, 0);
const Color white = Color.fromRGBO(255, 255, 255, 1);
const Color black = Color.fromRGBO(15, 15, 15, 1);
const Color color1 = Color.fromRGBO(23, 118, 88, 1);

// Tema principal
ThemeData themeA = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    surface: color1,
    onSurface: white,
    primary: white,
    onPrimary: color1,
    secondary: black,
    onSecondary: black,
    tertiary: transparent,
    error: Colors.red,
    onError: Colors.yellowAccent,
  ),
);

// Temas alternativos
ThemeData themeB = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    surface: black,
    onSurface: white,
    primary: white,
    onPrimary: black,
    secondary: black,
    onSecondary: black,
    tertiary: Colors.transparent,
    error: Colors.red,
    onError: Colors.yellowAccent,
  ),
);

// Lista com os temas que serão usados no aplicativo
final List<ThemeData> themes = [themeA, themeB];
