import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../components/audio_player.dart';

// Função principal que inicia o aplicativo e define AuscultaSimultanea como a tela inicial
void main() => runApp(const MaterialApp(home: AuscultaSimultanea()));

// Criação de um StatefulWidget para a tela AuscultaSimultanea
class AuscultaSimultanea extends StatefulWidget {
  const AuscultaSimultanea({super.key});

  @override
  _AuscultaSimultaneaState createState() => _AuscultaSimultaneaState();
}

// Classe de estado para gerenciar o comportamento dinâmico da tela
class _AuscultaSimultaneaState extends State<AuscultaSimultanea> {
  // Instâncias de AudioPlayer para gerenciar diferentes áudios
  late AudioPlayer player1 = AudioPlayer();
  late AudioPlayer player2 = AudioPlayer();
  late AudioPlayer player3 = AudioPlayer();
  late AudioPlayer player4 = AudioPlayer();
  late AudioPlayer player5 = AudioPlayer();
  late AudioPlayer player6 = AudioPlayer();
  late AudioPlayer player7 = AudioPlayer();
  late AudioPlayer player8 = AudioPlayer();
  late AudioPlayer player9 = AudioPlayer();
  late AudioPlayer player10 = AudioPlayer();
  late AudioPlayer player11 = AudioPlayer();
  late AudioPlayer player12 = AudioPlayer();

  // Método chamado quando o widget é inserido na árvore de widgets
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
    player8 = AudioPlayer();
    player9 = AudioPlayer();
    player10 = AudioPlayer();
    player11 = AudioPlayer();
    player12 = AudioPlayer();

    // Define o modo de liberação dos players como "stop" (parar após tocar)
    player1.setReleaseMode(ReleaseMode.stop);
    player2.setReleaseMode(ReleaseMode.stop);
    player3.setReleaseMode(ReleaseMode.stop);
    player4.setReleaseMode(ReleaseMode.stop);
    player5.setReleaseMode(ReleaseMode.stop);
    player6.setReleaseMode(ReleaseMode.stop);
    player7.setReleaseMode(ReleaseMode.stop);
    player8.setReleaseMode(ReleaseMode.stop);
    player9.setReleaseMode(ReleaseMode.stop);
    player10.setReleaseMode(ReleaseMode.stop);
    player11.setReleaseMode(ReleaseMode.stop);
    player12.setReleaseMode(ReleaseMode.stop);

    // Inicializa os arquivos de áudio
    _initAudio();
  }

  // Função para inicializar a reprodução de áudio carregando os arquivos dos assets
  Future<void> _initAudio() async {
    // Áudios da Ausculta Pulmonar
    await player1.setSourceAsset('audios/CrepitoForte.m4a');
    await player2.setSourceAsset('audios/CrepitoFraco.mp3');
    await player3.setSourceAsset('audios/Estridor.mp3');
    await player4.setSourceAsset('audios/Normalbc.mp3');
    await player5.setSourceAsset('audios/Pneumonia.m4a');
    await player6.setSourceAsset('audios/Ronco.mp3');
    await player7.setSourceAsset('audios/Sibilos.mp3');
    // Áudios da Ausculta Cardíaca
    await player8.setSourceAsset('audios/AtritoPericardico.m4a');
    await player9.setSourceAsset('audios/EstenoseAortica.m4a');
    await player10.setSourceAsset('audios/MurmurioDiastolico.mp3');
    await player11.setSourceAsset('audios/MurmurioSistolico.mp3');
    await player12.setSourceAsset('audios/ProlapsoValvulaMitral.m4a');
  }

  // Método para liberar recursos quando o widget é removido
  @override
  void dispose() {
    player1.dispose();
    player2.dispose();
    player3.dispose();
    player4.dispose();
    player5.dispose();
    super.dispose();
  }

  // Constrói a interface do usuário
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromRGBO(23, 118, 88, 1), // Define a cor de fundo
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor:
            const Color.fromRGBO(0, 0, 0, 0), // Define a cor da AppBar
        title: const Text(
          'Ausculta Simultânea',
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
                      'assets/images/logo.png',
                      height: 250,
                      width: 250,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Ausculta Pulmonar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: containerWidth,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          // Exibe os players de áudio para Ausculta Pulmonar
                          AudioContainer(
                            player: player1,
                            title: 'Crepito Forte',
                            description: 'Info CrepitoForte',
                            image: 'assets/images/logo.jpeg',
                          ),
                          AudioContainer(
                            player: player2,
                            title: 'Crepito Fraco',
                            description: 'Info Crepito Fraco',
                            image: 'assets/images/logo.jpeg',
                          ),
                          AudioContainer(
                            player: player3,
                            title: 'Estridor',
                            description: 'Info Estridor',
                            image: 'assets/images/logo.jpeg',
                          ),
                          AudioContainer(
                            player: player4,
                            title: 'Normal BC',
                            description: 'Info Normal BC',
                            image: 'assets/images/logo.jpeg',
                          ),
                          AudioContainer(
                            player: player5,
                            title: 'Pneumonia',
                            description: 'Info Pneumonia',
                            image: 'assets/images/logo.jpeg',
                          ),
                          AudioContainer(
                            player: player6,
                            title: 'Ronco',
                            description: 'Info Ronco',
                            image: 'assets/images/logo.jpeg',
                          ),
                          AudioContainer(
                            player: player7,
                            title: 'Sibilos',
                            description: 'Info Sibilos',
                            image: 'assets/images/logo.jpeg',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),
                    const Text(
                      'Ausculta Cardíaca',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: containerWidth,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          // Exibe os players de áudio para Ausculta Cardíaca
                          AudioContainer(
                            player: player8,
                            title: 'Atrito Pericárdico',
                            description: 'Info Atrito Pericárdico',
                            image: 'assets/images/logo.jpeg',
                          ),
                          AudioContainer(
                            player: player9,
                            title: 'Estenose Aórtica',
                            description: 'Info Estenose Aórtica',
                            image: 'assets/images/logo.jpeg',
                          ),
                          AudioContainer(
                            player: player10,
                            title: 'Murm. Diastólico',
                            description: 'Info Murmúrio Diastólico',
                            image: 'assets/images/logo.jpeg',
                          ),
                          AudioContainer(
                            player: player11,
                            title: 'Murm. Sistólico',
                            description: 'Info Murmúrio Sistólico',
                            image: 'assets/images/logo.jpeg',
                          ),
                          AudioContainer(
                            player: player12,
                            title: 'Prolapso V. Mitral',
                            description: 'Info Prolapso Válvula Mitral',
                            image: 'assets/images/logo.jpeg',
                          ),
                        ],
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
