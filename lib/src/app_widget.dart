// lib/app/app_widget.dart (VERSÃO CORRIGIDA)

import 'package:flutter/material.dart';
// Correção: Usando caminhos relativos
import 'ui/core/app_router.dart'; 
import 'ui/core/app_theme.dart'; // Importando o tema da aplicação

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      theme: appTheme,
      routerConfig: appRouter,
    );
  }
}
