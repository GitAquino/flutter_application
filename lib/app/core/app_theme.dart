// lib/app/core/app_theme.dart (ATUALIZADO COM SEU TEMA)

import 'package:flutter/material.dart';

// Definimos uma variável global para o tema, que pode ser acessada de qualquer lugar.
final ThemeData appTheme = ThemeData(
  // Usando as cores do seu NutriApp
  primaryColor: const Color.fromARGB(255, 220, 135, 17),
  scaffoldBackgroundColor: Colors.grey[100],
  
  // O ColorScheme é a forma moderna de definir cores no Flutter (Material 3)
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF2E7D32), // Sua cor verde principal
    brightness: Brightness.light,
  ),

  // Ativando o Material 3
  useMaterial3: true,

  // Estilo da AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2E7D32), // Usando sua cor verde
    foregroundColor: Colors.white,
    elevation: 2,
    centerTitle: true,
  ),

  // Estilo da BottomNavigationBar
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color.fromARGB(255, 202, 138, 35), // Usando sua cor verde
    unselectedItemColor: Colors.grey,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),

  visualDensity: VisualDensity.adaptivePlatformDensity,
);
