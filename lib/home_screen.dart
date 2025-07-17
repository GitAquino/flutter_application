import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

// Tela principal do aplicativo de nutrição
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SidebarXController(selectedIndex: 0, extended: true);

    return Scaffold(
      body: Row(
        children: [
          // A barra de navegação lateral
          SidebarX(
            controller: controller,
            // Tema da sidebar
            theme: SidebarXTheme(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32), // Cor de fundo da sidebar
                borderRadius: BorderRadius.circular(20),
              ),
              hoverColor: Colors.green.shade700,
              textStyle: TextStyle(color: Colors.white.withAlpha(179)), // 179 é ~70% de 255
              selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              itemTextPadding: const EdgeInsets.only(left: 30),
              selectedItemTextPadding: const EdgeInsets.only(left: 30),
              itemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF2E7D32)),
              ),
              selectedItemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                
                border: Border.all(
                  color: Colors.yellow.shade400.withAlpha(94), // 94 é ~37% de 255
                ),
                gradient: LinearGradient(
                  colors: [Colors.green.shade800, Colors.green.shade600],
                ),
                boxShadow: [
                  BoxShadow(
                    
                    color: Colors.black.withAlpha(71), // 71 é ~28% de 255
                    blurRadius: 30,
                  )
                ],
              ),
              iconTheme: IconThemeData(
                
                color: Colors.white.withAlpha(179), // 179 é ~70% de 255
                size: 20,
              ),
              selectedIconTheme: const IconThemeData(
                color: Colors.white,
                size: 20,
              ),
            ),
            // Define se a sidebar começa expandida ou não
            extendedTheme: const SidebarXTheme(
              width: 200, // Largura da sidebar expandida
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32),
              ),
            ),
            // O rodapé da sidebar, útil para um botão de logout ou configurações
            footerDivider: Divider(color: Colors.white.withAlpha(77), height: 1), // 77 é ~30% de 255
            // O cabeçalho da sidebar, onde podemos colocar o logo ou nome do app
            headerBuilder: (context, extended) {
              return SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  // Exibe o logo e o texto quando expandido
                  child: extended
                      ? Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset('lib/assets/logo.png', height: 40),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'NutriApp',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      // Exibe apenas o logo quando retraído
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset('lib/assets/logo.png', height: 40),
                        ),
                ),
              );
            },
            // Itens de navegação
            items: [
              SidebarXItem(
                icon: Icons.home,
                label: 'Início',
                onTap: () {
                  debugPrint('Navegando para Início');
                },
              ),
              SidebarXItem(
                icon: Icons.restaurant_menu,
                label: 'Planos Alimentares',
              ),
              SidebarXItem(
                icon: Icons.bar_chart,
                label: 'Meu Progresso',
              ),
              SidebarXItem(
                icon: Icons.fastfood,
                label: 'Alimentos',
              ),
              SidebarXItem(
                icon: Icons.book,
                label: 'Receitas',
              ),
              SidebarXItem(
                icon: Icons.settings,
                label: 'Configurações',
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: _ScreensExample(
                controller: controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget que exibe a tela correspondente ao item selecionado na sidebar
class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    required this.controller,
  });

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    
    // AnimatedBuilder reconstrói o widget quando o valor do controller muda (selectedIndex)
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Simplesmente exibe uma tela de exemplo baseada no índice selecionado
        switch (controller.selectedIndex) {
          case 0:
            return const Center(child: Text('Tela de Início', style: TextStyle(fontSize: 24)));
          case 1:
            return const Center(child: Text('Tela de Planos Alimentares', style: TextStyle(fontSize: 24)));
          case 2:
            return const Center(child: Text('Tela de Meu Progresso', style: TextStyle(fontSize: 24)));
          case 3:
            return const Center(child: Text('Tela de Alimentos', style: TextStyle(fontSize: 24)));
          case 4:
            return const Center(child: Text('Tela de Receitas', style: TextStyle(fontSize: 24)));
          case 5:
            return const Center(child: Text('Tela de Configurações', style: TextStyle(fontSize: 24)));
          default:
            return const Center(child: Text('Página não encontrada', style: TextStyle(fontSize: 24)));
        }
      },
    );
  }
}