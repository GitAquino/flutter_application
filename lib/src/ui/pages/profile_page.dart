import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center( // O corpo da página
        child: Text(
          'Pagina do Usuário',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
