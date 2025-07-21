// lib/app/core/app_router.dart (VERSÃO CORRIGIDA)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// CORREÇÃO: Remova a importação da HomePage que não existe.
// import 'package:flutter_application/modules/home/presenter/home_page.dart';

// Agora só precisamos importar as páginas que realmente existem.
import '../pages/placeholder_page.dart';
import '../widgets/scaffold_with_nav_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKeyHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorKeyAlimentos = GlobalKey<NavigatorState>(debugLabel: 'shellAlimentos');
final _shellNavigatorKeyOrders = GlobalKey<NavigatorState>(debugLabel: 'shellOrders');
final _shellNavigatorKeyShop = GlobalKey<NavigatorState>(debugLabel: 'shellShop');

final appRouter = GoRouter(
  initialLocation: '/home', // A rota inicial continua sendo /home
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
            GoRoute(
              path: '/home',
              // CORREÇÃO: Use a PlaceholderPage para a aba Home também.
              builder: (context, state) => const PlaceholderPage(title: 'Home'), 
            ),
          ],
        ),

        
        // Branch 2: Pedidos
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyOrders,
          routes: [
            GoRoute(
              path: '/orders',
              builder: (context, state) => const PlaceholderPage(title: 'Pedidos'),
            ),
          ],
        ),

        // Branch 3: Alimentos
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyAlimentos,
          routes: [
            GoRoute(
              path: '/alimentos',
              builder: (context, state) => const PlaceholderPage(title: 'Alimentos'),
            ),
          ],
        ),

        // Branch 4: Compras
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKeyShop,
          routes: [
            GoRoute(
              path: '/shop',
              builder: (context, state) => const PlaceholderPage(title: 'Shop'),
            ),
          ],
        ),
      ],
    ),
  ],
);
