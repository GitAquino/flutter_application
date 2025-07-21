// lib/app/core/app_router.dart (VERSÃO FINAL E LIMPA)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Usando imports relativos para evitar problemas com o nome do pacote.
// O caminho ../../ sobe de 'core' para 'app', e de 'app' para 'lib'.
import '../../modules/home/presenter/home_page.dart';
import '../../modules/search/presenter/search_page.dart';
import '../../modules/food/presenter/food_page.dart';
import '../../modules/shop/presenter/shop_page.dart';

import '../widgets/scaffold_with_nav_bar.dart';

// Chaves de navegação com os nomes corretos e consistentes.
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorKeySearch = GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
final _shellNavigatorKeyFood = GlobalKey<NavigatorState>(debugLabel: 'shellFood');
final _shellNavigatorKeyShop = GlobalKey<NavigatorState>(debugLabel: 'shellShop');

final appRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      
      branches: [
        // Branch 1: Home
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyHome,
          routes: [
            GoRoute(path: '/home', builder: (context, state) => const HomePage()),
          ],
        ),

        // Branch 2: Busca
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeySearch,
          routes: [
            GoRoute(path: '/search', builder: (context, state) => const SearchPage()),
          ],
        ),

        // Branch 3: Food
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyFood, // Usando a chave correta
          routes: [
            // O path é '/food' e o builder usa a FoodPage
            GoRoute(path: '/food', builder: (context, state) => const FoodPage()),
          ],
        ),

        // Branch 4: Shop
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyShop, // Usando a chave correta
          routes: [
            // O path é '/shop' e o builder usa a ShopPage
            GoRoute(path: '/shop', builder: (context, state) => const ShopPage()),
          ],
        ),
      ],
    ),
  ],
);
