// lib/modules/search/presenter/search_page.dart

import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Note que o Scaffold aqui é importante.
    // Ele fornece a estrutura básica (como a AppBar) para a página
    // que será exibida DENTRO do nosso Scaffold principal com a SalomonBar.
    return Scaffold(
      appBar: AppBar(
        title: const Text('NathApp'),
      ),
      body: const Center(
        child: Text(
          'Página de Busca',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
