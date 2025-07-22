import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center( // O corpo da página
        child: Text(
          'Página Inicial',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
