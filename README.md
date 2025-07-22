# Nathapp

Informações nutricionais na palma da sua mão!
Esse projeto tem como finalidade fornecer ao público informações nutricionais dos alimentos, trazendo consigo mais conhecimento e autonomia
para estruturar sua alimentação da melhor forma!

## Estrutura

Linguagem e framework utilizado:

- Flutter
- Dart

Plataformas disponíveis:

- Android 
- IOS 
- Web 

# Arquitetura do Projeto

.
├── android/
├── ios/
├── lib/
│   ├── assets/
│   │   └── logo.png
│   ├── src/
│   │   ├── core/
│   │   │   ├── app_router.dart     # Gerencia as rotas/navegação do app
│   │   │   └── app_theme.dart      # Define o tema visual (cores, fontes)
│   │   ├── data/
│   │   │   ├── models/         # Classes de modelo (ex: User, Product)
│   │   │   ├── repositories/   # Lógica de acesso a dados (API, banco de dados)
│   │   │   └── services/       # Serviços de negócio ou de terceiros
│   │   ├── ui/
│   │   │   ├── controllers/    # Lógica de estado para as telas (ex: BLoC, Provider)
│   │   │   ├── pages/          # As telas completas do aplicativo
│   │   │   │   ├── food_page.dart
│   │   │   │   ├── home_page.dart
│   │   │   │   ├── placeholder_page.dart
│   │   │   │   ├── search_page.dart
│   │   │   │   └── shop_page.dart
│   │   │   └── widgets/        # Widgets reutilizáveis
│   │   │       ├── app_widget.dart
│   │   │       └── scaffold_with_nav_bar.dart
│   └── main.dart               # Ponto de entrada principal do aplicativo
├── linux/
├── macos/
├── test/
├── web/
├── windows/
├── .gitignore
├── analysis_options.yaml
└── pubspec.yaml
