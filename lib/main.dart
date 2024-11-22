import 'package:flutter/material.dart';
import 'package:simulatech/pages/pagina_inicial.dart';

void main() async {
  // Garantindo a inicialização dos widgets antes de rodar o app
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

// Widget principal do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela Inicial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(23, 118, 88, 1),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color.fromRGBO(23, 118, 88, 1),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      // Define a HomeScreen como a tela inicial
      home: const HomeScreen(),
      routes: {
        '/pagina_inicial': (context) => const PaginaInicial(),
      },
    );
  }
}

// Widget da tela inicial do aplicativo
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold para a estrutura da tela
    return Scaffold(
      // Container para definir a cor de fundo da tela
      body: Center(
        child: Container(
          color: const Color.fromRGBO(23, 118, 88, 1),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centraliza na vertical
            children: <Widget>[
              // Imagem do logo com espaçamento ao redor
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200, // Ajuste de tamanho da imagem para responsividade
                  fit: BoxFit.contain,
                ),
              ),
              // Linha para agrupar os botões de login e cadastro
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centraliza os botões na linha
                children: <Widget>[
                  // Botão para fazer login
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pagina_inicial');
                    },
                    child: const Text('Fazer Login'),
                  ),
                  const SizedBox(width: 20),
                  // Botão para cadastro
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/pagina_inicial');
                    },
                    child: const Text('Cadastre-se'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
