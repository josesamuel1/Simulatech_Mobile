import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../components/audio_player.dart';

// Função principal que inicia o aplicativo e define a página inicial como AuscultaCardiaca
void main() => runApp(const MaterialApp(home: AuscultaCardiaca()));

// Criação do widget AuscultaCardiaca
class AuscultaCardiaca extends StatefulWidget {
  const AuscultaCardiaca({super.key});

  @override
  _AuscultaCardiacaState createState() => _AuscultaCardiacaState();
}

// Estado do widget AuscultaCardiaca
class _AuscultaCardiacaState extends State<AuscultaCardiaca> {
  // Criação de objetos para controle de reprodução de áudio
  late AudioPlayer player1 = AudioPlayer();
  late AudioPlayer player2 = AudioPlayer();
  late AudioPlayer player3 = AudioPlayer();
  late AudioPlayer player4 = AudioPlayer();
  late AudioPlayer player5 = AudioPlayer();

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

    // Define o modo de liberação de cada player para 'stop'
    player1.setReleaseMode(ReleaseMode.stop);
    player2.setReleaseMode(ReleaseMode.stop);
    player3.setReleaseMode(ReleaseMode.stop);
    player4.setReleaseMode(ReleaseMode.stop);
    player5.setReleaseMode(ReleaseMode.stop);

    // Inicializa as fontes de áudio
    _initAudio();
  }

  // Função para inicializar a reprodução de áudio
  Future<void> _initAudio() async {
    // Define as fontes de áudio para cada player, usando arquivos de áudio armazenados localmente
    await player1.setSourceAsset('ausc-cardiaca/AtritoPericardico.m4a');
    await player2.setSourceAsset('ausc-cardiaca/EstenoseAortica.m4a');
    await player3.setSourceAsset('ausc-cardiaca/MurmurioDiastolico.mp3');
    await player4.setSourceAsset('ausc-cardiaca/MurmurioSistolico.mp3');
    await player5.setSourceAsset('ausc-cardiaca/ProlapsoValvulaMitral.m4a');
  }

  // Função chamada ao destruir o widget, garantindo a liberação de recursos dos players
  @override
  void dispose() {
    player1.dispose();
    player2.dispose();
    player3.dispose();
    player4.dispose();
    player5.dispose();
    super.dispose();
  }

  // Construção do layout da página
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(23, 118, 88, 1),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        title: const Text(
          'Ausculta Cardíaca',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
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
                        title: 'Atrito Pericárdico',
                        // Descrição do áudio
                        description: 'Info Atrito Pericárdico',
                        image: 'assets/app/logo.jpeg',
                      ),
                    ),
                    SizedBox(
                      width: containerWidth,
                      child: AudioContainer(
                        player: player2,
                        title: 'Estenose Aórtica',
                        description: 'Info Estenose Aórtica',
                        image: 'assets/app/logo.jpeg',
                      ),
                    ),
                    SizedBox(
                      width: containerWidth,
                      child: AudioContainer(
                        player: player3,
                        title: 'Murm. Diastólico',
                        description: 'Info Murmúrio Diastólico',
                        image: 'assets/app/logo.jpeg',
                      ),
                    ),
                    SizedBox(
                      width: containerWidth,
                      child: AudioContainer(
                        player: player4,
                        title: 'Murm. Sistólico',
                        description: 'Info Murmúrio Sistólico',
                        image: 'assets/app/logo.jpeg',
                      ),
                    ),
                    SizedBox(
                      width: containerWidth,
                      child: AudioContainer(
                        player: player5,
                        title: 'Prolapso V. Mitral',
                        description: 'Info Prolapso Válvula Mitral',
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
  }
}
