import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/audio_player.dart';
import '../cubits/theme/theme_cubit.dart';

// Função principal que inicia o aplicativo e define a página inicial como AuscultaAbdominal
void main() => runApp(const MaterialApp(home: AuscultaAbdominal()));

// Criação do widget AuscultaAbdominal
class AuscultaAbdominal extends StatefulWidget {
  const AuscultaAbdominal({super.key});

  @override
  _AuscultaAbdominalState createState() => _AuscultaAbdominalState();
}

// Estado do widget AuscultaAbdominal
class _AuscultaAbdominalState extends State<AuscultaAbdominal> {
  // Criação de objetos para controle de reprodução de áudio
  late AudioPlayer player1 = AudioPlayer();
  late AudioPlayer player2 = AudioPlayer();
  late AudioPlayer player3 = AudioPlayer();

  // Inicialização do estado do widget
  @override
  void initState() {
    super.initState();
    // Inicializa as instâncias de AudioPlayer
    player1 = AudioPlayer();
    player2 = AudioPlayer();
    player3 = AudioPlayer();

    // Define o modo de liberação de cada player para 'stop'
    player1.setReleaseMode(ReleaseMode.stop);
    player2.setReleaseMode(ReleaseMode.stop);
    player3.setReleaseMode(ReleaseMode.stop);

    // Inicializa as fontes de áudio
    _initAudio();
  }

  // Função para inicializar a reprodução de áudio
  Future<void> _initAudio() async {
    // Define as fontes de áudio para cada player, usando arquivos de áudio armazenados localmente
    await player1.setSourceAsset('app/AudioTeste.mpeg');
    await player2.setSourceAsset('app/AudioTeste.mpeg');
    await player3.setSourceAsset('app/AudioTeste.mpeg');
  }

  // Função chamada ao destruir o widget, garantindo a liberação de recursos dos players
  @override
  void dispose() {
    player1.dispose();
    player2.dispose();
    player3.dispose();
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
              'Ausculta Abdominal',
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
                        const SizedBox(height: 20.0),
                        SizedBox(
                          width: containerWidth,
                          child: AudioContainer(
                            // Associa o player ao componente de áudio
                            player: player1,
                            // Título do áudio
                            title: 'Título Abdominal 1',
                            // Descrição do áudio
                            description: 'Info Abdominal 1',
                            image: 'assets/app/logo.jpeg',
                          ),
                        ),
                        SizedBox(
                          width: containerWidth,
                          child: AudioContainer(
                            player: player2,
                            title: 'Título Abdominal 2',
                            description: 'Info Abdominal 2',
                            image: 'assets/app/logo.jpeg',
                          ),
                        ),
                        SizedBox(
                          width: containerWidth,
                          child: AudioContainer(
                            player: player3,
                            title: 'Título Abdominal 3',
                            description: 'Info Abdominal 3',
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
