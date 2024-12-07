import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Pacote para ícones do Instagram e WhatsApp
import 'package:url_launcher/url_launcher.dart'; // Pacote para abrir URLs

import '../cubits/theme/theme_cubit.dart';
import '../pages/ausculta_abdominal.dart';
import '../pages/ausculta_cardiaca.dart';
import '../pages/ausculta_pulmonar.dart';
import '../pages/ausculta_simultanea.dart';
import '../utils/constants.dart';

// Classe principal que representa a página inicial
class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, state) {
        context.read<ThemeCubit>().state;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: state.themeData.colorScheme.surface,
            foregroundColor: state.themeData.colorScheme.onSurface,
            actions: [
              IconButton(
                icon: const Icon(Icons.brightness_6),
                onPressed: () {
                  context.read<ThemeCubit>().changeTheme();
                },
              ),
            ],
          ),
          backgroundColor: state.themeData.colorScheme.surface,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // Centraliza o conteúdo verticalmente
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Exibe o logo no centro da tela
                  Image.asset(
                    'assets/app/logo.png',
                    width: 250,
                    height: 250,
                  ),
                  const SizedBox(height: 30),
                  // Botões organizados em um layout flexível (Wrap)
                  Wrap(
                    alignment:
                        WrapAlignment.center, // Alinha os botões no centro
                    spacing: 40.0, // Espaçamento horizontal entre os botões
                    runSpacing:
                        20.0, // Espaçamento vertical entre as linhas de botões
                    children: [
                      // Botão para "Ausculta Pulmonar"
                      _buildButton(
                        context: context,
                        label: 'Ausculta Pulmonar',
                        imagePath: 'assets/ausc-pulmonar/pulmao.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuscultaPulmonar(),
                            ),
                          );
                        },
                      ),
                      // Botão para "Ausculta Cardíaca"
                      _buildButton(
                        context: context,
                        label: 'Ausculta Cardíaca',
                        imagePath: 'assets/ausc-cardiaca/coracao.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuscultaCardiaca(),
                            ),
                          );
                        },
                      ),
                      // Botão para "Ausculta Simultânea", com imagens empilhadas
                      _buildButton(
                        context: context,
                        label: 'Ausculta Simultânea',
                        imagePath: null,
                        stackImages: [
                          'assets/ausc-pulmonar/pulmao.png',
                          'assets/ausc-cardiaca/coracao.png',
                        ],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuscultaSimultanea(),
                            ),
                          );
                        },
                      ),
                      // Botão para "Ausculta Abdominal"
                      _buildButton(
                        context: context,
                        label: 'Ausculta Abdominal',
                        imagePath: 'assets/ausc-abdominal/abdomen.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuscultaAbdominal(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Rodapé da página com ícones e texto
          bottomNavigationBar: Container(
            // Cor do fundo do rodapé
            color: state.themeData.colorScheme.surface,
            // Espaçamento interno
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              // Minimiza o widget para caber no bottomNavigation
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Texto com informações de contato
                Text(
                  footerText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: state.themeData.colorScheme.onSurface,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Botão para abrir o Instagram
                    IconButton(
                      onPressed: () async {
                        if (await canLaunchUrl(Uri.parse(instagramUrl))) {
                          // Abre o link no navegador
                          await launchUrl(Uri.parse(instagramUrl));
                        } else {
                          // Exibe erro caso não consiga abrir
                          throw _showErrorDialog(context);
                        }
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.instagram,
                        color: state.themeData.colorScheme.onSurface,
                      ),
                    ),
                    // Botão para abrir o WhatsApp
                    IconButton(
                      onPressed: () async {
                        // Link para iniciar o WhatsApp
                        final whatsappContact =
                            '$whatsappUrl${Uri.encodeComponent(whatsappMessage)}';

                        if (await canLaunchUrl(Uri.parse(whatsappContact))) {
                          // Abre o WhatsApp com a mensagem
                          await launchUrl(Uri.parse(whatsappContact));
                        } else {
                          // Exibe erro caso não consiga abrir
                          throw _showErrorDialog(context);
                        }
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: state.themeData.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Função para criar os botões na página
  Widget _buildButton({
    required BuildContext context,
    required String label, // Texto do botão
    required VoidCallback onTap, // Função chamada ao clicar no botão
    String? imagePath, // Caminho da imagem principal
    List<String>? stackImages, // Lista de imagens empilhadas
  }) {
    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, state) {
        context.read<ThemeCubit>().state;
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap, // Define a ação ao clicar no botão
          child: Column(
            children: [
              // Container que exibe a imagem ou as imagens empilhadas
              Container(
                // Espaçamento interno
                padding: const EdgeInsets.all(6.0),
                // Largura e Altura do botão
                width: 120, height: 120,
                // Cor de fundo
                decoration: BoxDecoration(
                  color: state.themeData.colorScheme.onSurface,
                  borderRadius:
                      BorderRadius.circular(20.0), // Borda arredondada
                ),
                child: stackImages == null
                    ? Image.asset(imagePath!) // Exibe uma única imagem
                    : Stack(
                        children: [
                          // Primeira imagem da pilha
                          Image.asset(
                            stackImages[0],
                            width: 60.0,
                            height: 60.0,
                          ),
                          // Segunda imagem posicionada no canto inferior direito
                          Positioned(
                            bottom: 1.0,
                            right: -5.0,
                            child: Image.asset(
                              stackImages[1],
                              width: 60.0,
                              height: 60.0,
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 5.0),
              // Texto do botão
              Text(
                label,
                style: TextStyle(
                  color: state.themeData.colorScheme.onSurface,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Object _showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<ThemeCubit, ThemeState>(
          listener: (context, state) {
            context.read<ThemeCubit>().state;
          },
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: state.themeData.colorScheme.onSurface,
              title: Text(
                'Erro ao tentar acessar o link.',
                style: TextStyle(
                    fontSize: 16.0,
                    color: state.themeData.colorScheme.secondary),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Fechar',
                    style: TextStyle(
                      color: state.themeData.colorScheme.surface,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
