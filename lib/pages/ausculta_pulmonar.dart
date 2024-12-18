import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/audio_player.dart';
import '../cubits/theme/theme_cubit.dart';

// Função principal que inicia o aplicativo e define a página inicial como AuscultaPulmonar
void main() => runApp(const MaterialApp(home: AuscultaPulmonar()));

// Criação do widget AuscultaPulmonar
class AuscultaPulmonar extends StatefulWidget {
  const AuscultaPulmonar({super.key});

  @override
  _AuscultaPulmonarState createState() => _AuscultaPulmonarState();
}

// Estado do widget AuscultaPulmonar
class _AuscultaPulmonarState extends State<AuscultaPulmonar> {
  // Criação de objetos para controle de reprodução de áudio
  late AudioPlayer player1 = AudioPlayer();
  late AudioPlayer player2 = AudioPlayer();
  late AudioPlayer player3 = AudioPlayer();
  late AudioPlayer player4 = AudioPlayer();
  late AudioPlayer player5 = AudioPlayer();
  late AudioPlayer player6 = AudioPlayer();
  late AudioPlayer player7 = AudioPlayer();

  // Inicialização do estado do widget
  @override
  void initState() {
    super.initState();
    // Inicializa as instâncias de AudioPlayer
    player1 = AudioPlayer();
    player2 = AudioPlayer();
    player3 = AudioPlayer();
    player4 = AudioPlayer();
    player5 = AudioPlayer();
    player6 = AudioPlayer();
    player7 = AudioPlayer();

    // Define o modo de liberação de cada player para 'stop'
    player1.setReleaseMode(ReleaseMode.stop);
    player2.setReleaseMode(ReleaseMode.stop);
    player3.setReleaseMode(ReleaseMode.stop);
    player4.setReleaseMode(ReleaseMode.stop);
    player5.setReleaseMode(ReleaseMode.stop);
    player6.setReleaseMode(ReleaseMode.stop);
    player7.setReleaseMode(ReleaseMode.stop);

    // Inicializa as fontes de áudio
    _initAudio();
  }

  // Função para inicializar a reprodução de áudio
  Future<void> _initAudio() async {
    // Define as fontes de áudio para cada player, usando arquivos de áudio armazenados localmente
    await player1.setSourceAsset('ausc-pulmonar/CrepitoForte.m4a');
    await player2.setSourceAsset('ausc-pulmonar/CrepitoFraco.mp3');
    await player3.setSourceAsset('ausc-pulmonar/Estridor.mp3');
    await player4.setSourceAsset('ausc-pulmonar/Normalbc.mp3');
    await player5.setSourceAsset('ausc-pulmonar/Pneumonia.m4a');
    await player6.setSourceAsset('ausc-pulmonar/Ronco.mp3');
    await player7.setSourceAsset('ausc-pulmonar/Sibilos.mp3');
  }

  // Função chamada ao destruir o widget, garantindo a liberação de recursos dos players
  @override
  void dispose() {
    player1.dispose();
    player2.dispose();
    player3.dispose();
    player4.dispose();
    player5.dispose();
    player6.dispose();
    player7.dispose();
    super.dispose();
  }

  // Construção do layout da página
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, state) {
        context.read<ThemeCubit>().state;
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: state.themeData.colorScheme.surface,
          appBar: AppBar(
            backgroundColor: state.themeData.colorScheme.tertiary,
            foregroundColor: state.themeData.colorScheme.onSurface,
            title: const Text(
              'Ausculta Pulmonar',
              style: TextStyle(fontSize: 24),
            ),
          ),
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Tamanho padrão
                  double containerWidth = constraints.maxWidth;
                  // Verifica se a largura da tela é maior que um valor específico
                  if (constraints.maxWidth >= 600) {
                    // Tamanho para computadores (50%)
                    containerWidth = constraints.maxWidth * 0.66;
                  }
                  return Center(
                    child: Column(
                      // Centraliza o conteúdo na tela
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/app/logo.png',
                          height: 250,
                          width: 250,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: containerWidth,
                          child: AudioContainer(
                            // Associa o player ao componente de áudio
                            player: player1,
                            // Título do áudio
                            title: 'Crepito Forte',
                            // Descrição do áudio
                            description: 'Info CrepitoForte',
                            // Link da imagem
                            image: 'assets/app/logo.jpeg',
                          ),
                        ),
                        SizedBox(
                          width: containerWidth,
                          child: AudioContainer(
                            player: player2,
                            title: 'Crepito Fraco',
                            description: 'Info Crepito Fraco',
                            image: 'assets/app/logo.jpeg',
                          ),
                        ),
                        SizedBox(
                          width: containerWidth,
                          child: AudioContainer(
                            player: player3,
                            title: 'Estridor',
                            description: 'Info Estridor',
                            image: 'assets/app/logo.jpeg',
                          ),
                        ),
                        SizedBox(
                          width: containerWidth,
                          child: AudioContainer(
                            player: player4,
                            title: 'Normal BC',
                            description: 'Info Normal BC',
                            image: 'assets/app/logo.jpeg',
                          ),
                        ),
                        SizedBox(
                          width: containerWidth,
                          child: AudioContainer(
                            player: player5,
                            title: 'Pneumonia',
                            description: 'Info Pneumonia',
                            image: 'assets/app/logo.jpeg',
                          ),
                        ),
                        SizedBox(
                          width: containerWidth,
                          child: AudioContainer(
                            player: player6,
                            title: 'Ronco',
                            description: 'Info Ronco',
                            image: 'assets/app/logo.jpeg',
                          ),
                        ),
                        SizedBox(
                          width: containerWidth,
                          child: AudioContainer(
                            player: player7,
                            title: 'Sibilos',
                            description: 'Info Sibilos',
                            image: 'assets/app/logo.jpeg',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
