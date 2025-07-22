// lib/src/ui/widgets/custom_app_bar.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // O título será dinâmico, recebido por parâmetro
      title: Text('Nathapp'),
      
      // 'actions' é a lista de widgets que aparece no lado direito da AppBar
      actions: [
        IconButton(
          icon: const Icon(Icons.person_outline),
          tooltip: 'Perfil', // Texto que aparece ao pressionar e segurar
          onPressed: () {
            // Ação ao clicar no ícone.
            // Exemplo: navegar para a tela de perfil.
            // Certifique-se de que a rota '/profile' existe no seu app_router.dart
            context.go('/profile'); 
            
            // Se ainda não tiver a tela de perfil, pode deixar um print por enquanto:
            // print('Ícone de perfil clicado!');
          },
        ),
        // Adiciona um pequeno espaçamento à direita
        const SizedBox(width: 8), 
      ],
    );
  }

  // Esta parte é necessária para que o Flutter saiba a altura da sua AppBar customizada.
  // kToolbarHeight é a altura padrão da AppBar.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
