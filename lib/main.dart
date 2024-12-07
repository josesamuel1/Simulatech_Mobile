import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/theme/theme_cubit.dart';
import 'pages/pagina_inicial.dart';

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
    return BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Tela Inicial',
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            home: const HomeScreen(),
            routes: {
              '/pagina_inicial': (context) => const PaginaInicial(),
            },
          );
        },
      ),
    );
  }
}

// Widget da tela inicial do aplicativo
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold para a estrutura da tela
    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, state) {
        context.read<ThemeCubit>().state;
      },
      builder: (context, state) {
        return Scaffold(
          // Container para definir a cor de fundo da tela
          body: Center(
            child: Container(
              color: state.themeData.colorScheme.surface,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                // Centraliza na vertical
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Imagem do logo com espaçamento ao redor
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Image.asset(
                      'assets/app/logo.png',
                      width:
                          200, // Ajuste de tamanho da imagem para responsividade
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Linha para agrupar os botões de login e cadastro
                  Row(
                    // Centraliza os botões na linha
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Botão para fazer login
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            state.themeData.colorScheme.primary,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            state.themeData.colorScheme.onPrimary,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/pagina_inicial');
                        },
                        child: const Text('Fazer Login'),
                      ),
                      const SizedBox(width: 20.0),
                      // Botão para cadastro
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            state.themeData.colorScheme.primary,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            state.themeData.colorScheme.onPrimary,
                          ),
                        ),
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
      },
    );
  }
}
