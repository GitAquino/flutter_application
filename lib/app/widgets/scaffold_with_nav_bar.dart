// lib/app/widgets/scaffold_with_nav_bar.dart (VERSÃO ATUALIZADA)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// 1. Importe o novo pacote
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O corpo da tela continua sendo o mesmo, controlado pelo GoRouter
      body: navigationShell,
      
      // 2. Substituímos o BottomNavigationBar pelo SalomonBottomBar
      bottomNavigationBar: SalomonBottomBar(
        // O índice atual continua vindo do GoRouter
        currentIndex: navigationShell.currentIndex,
        
        // A função de callback para mudar de aba também é a mesma
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },

        // Usando as cores do tema que definimos no app_theme.dart
        // Isso deixa o visual consistente com o resto do seu app.
        selectedItemColor: Theme.of(context).primaryColor, // Cor do item ativo
        unselectedItemColor: Colors.grey[600], // Cor dos itens inativos

        // 3. Definimos os itens usando o formato do SalomonBottomBar
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home), // Ícone quando ativo
            title: const Text("Início"),
          ),

          /// Busca
          SalomonBottomBarItem(
            icon: const Icon(Icons.search_outlined),
            activeIcon: const Icon(Icons.search),
            title: const Text("Busca"),
          ),

          /// Pedidos
          SalomonBottomBarItem(
            icon: const Icon(Icons.egg_alt_outlined),
            activeIcon: const Icon(Icons.egg_alt),
            title: const Text("Alimentos"),
          ),

          /// Perfil
          SalomonBottomBarItem(
            icon: const Icon(Icons.shopping_cart_outlined),
            activeIcon: const Icon(Icons.shopping_cart),
            title: const Text("Compras"),
          ),
        ],
      ),
    );
  }
}
