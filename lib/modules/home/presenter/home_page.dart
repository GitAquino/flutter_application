// lib/modules/home/presenter/home_page.dart

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'), // A barra de título da página
      ),
      body: const Center( // O corpo da página
        child: Text(
          'Página Inicial',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
