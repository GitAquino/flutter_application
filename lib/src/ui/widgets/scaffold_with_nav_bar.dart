// lib/src/ui/widgets/scaffold_with_nav_bar.dart (VERSÃO ATUALIZADA)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// 1. Importe sua nova AppBar customizada
import 'custom_app_bar.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  // 2. Crie uma função para obter o título correto com base na aba atual
  String _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return 'Início';
      case 1:
        return 'Busca';
      case 2:
        return 'Alimentos';
      case 3:
        return 'Compras';
      default:
        return 'NutriApp'; // Um título padrão
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 3. Adicione a sua AppBar customizada aqui
      appBar: CustomAppBar(
        title: _getTitleForIndex(navigationShell.currentIndex),
      ),

      body: navigationShell,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            title: const Text("Início"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.search_outlined),
            activeIcon: const Icon(Icons.search),
            title: const Text("Busca"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.egg_alt_outlined),
            activeIcon: const Icon(Icons.egg_alt),
            title: const Text("Alimentos"),
          ),
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
