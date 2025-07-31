import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importe para configurar a orientação e a barra de status

// 1. Importe a tela principal do Fitness App. 
//    Ajuste o caminho se sua estrutura de pastas for diferente.
import './src/fitness_app/fitness_app_home_screen.dart'; 

void main() async {
  // Garante que os bindings do Flutter foram inicializados antes de rodar o app.
  // Necessário para usar SystemChrome.
  WidgetsFlutterBinding.ensureInitialized();

  // Opcional, mas recomendado: Força o app a ficar sempre no modo retrato (vertical).
  // O template de fitness foi desenhado para essa orientação.
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  
  // 2. Chame a função runApp com o novo Widget principal.
  runApp(FitnessApp()); 
}

// 3. Crie o Widget principal do seu aplicativo.
class FitnessApp extends StatelessWidget {
  const FitnessApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Configura a aparência da barra de status (onde fica o relógio, bateria, etc.)
    // para combinar com o design do app.
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Fitness App',
      // Remove a faixa de "Debug" no canto superior direito.
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // O template de fitness usa seu próprio tema, então o tema principal aqui
        // não é tão crítico, mas é bom ter uma base.
      ),
      // 4. Defina a FitnessAppHomeScreen como a tela inicial do seu aplicativo.
      home: FitnessAppHomeScreen(), 
    );
  }
}
