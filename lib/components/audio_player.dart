import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/theme/theme_cubit.dart';

class AudioContainer extends StatefulWidget {
  final AudioPlayer player;
  final Duration? duration;
  final Duration? position;
  final String title;
  final String description;
  final String image;

  const AudioContainer({
    super.key,
    required this.player,
    required this.title,
    required this.description,
    required this.image,
    this.duration,
    this.position,
  });

  @override
  State<StatefulWidget> createState() => _AudioContainerState();
}

class _AudioContainerState extends State<AudioContainer> {
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSub;
  StreamSubscription? _positionSub;
  StreamSubscription? _playerCompleteSub;
  StreamSubscription? _playerChangeStateSub;

  bool get _isPlaying => _playerState == PlayerState.playing;
  bool get _isPaused => _playerState == PlayerState.paused;

  @override
  void setState(VoidCallback func) {
    // As subscrições só podem ser fechadas de forma assíncrona,
    // caso contrário, eventos inesperados podem ocorrer quando
    // o player de áudio for descartados.
    if (mounted) {
      super.setState(func);
    }
  }

  @override
  void initState() {
    super.initState();
    // Usando os valores iniciais do player
    _playerState = widget.player.state;
    widget.player.getDuration().then((value) => setState(() {
          _duration = value;
        }));
    widget.player.getCurrentPosition().then(
          (value) => setState(() {
            _position = value;
          }),
        );
    _initStreams();
  }

  // Definindo eventos iniciais
  void _initStreams() {
    // Duração do player
    _durationSub = widget.player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    // Posição do player
    _positionSub = widget.player.onPositionChanged.listen((position) {
      setState(() => _position = position);
    });

    // Caso o player tenha completado a reprodução de áudio
    _playerCompleteSub = widget.player.onPlayerComplete.listen((complete) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    // Caso o player mude a reprodução do áudio
    _playerChangeStateSub = widget.player.onPlayerStateChanged.listen((change) {
      setState(() => _playerState = change);
    });
  }

  // Função que vai mudar o estado do player para reproduzir o som.
  Future<void> _play() async {
    await widget.player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  // Função que vai mudar o estado do player para pausar o som.
  Future<void> _pause() async {
    await widget.player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  // Função que vai mudar o estado do player para parar o som.
  Future<void> _stop() async {
    await widget.player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }

  // Descartando todas as informações do player
  @override
  void dispose() {
    _durationSub?.cancel();
    _positionSub?.cancel();
    _playerCompleteSub?.cancel();
    _playerChangeStateSub?.cancel();
    super.dispose();
  }

  void _showImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<ThemeCubit, ThemeState>(
          listener: (context, state) {
            context.read<ThemeCubit>().state;
          },
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: state.themeData.colorScheme.onSurface,
              content: Image.asset(
                widget.image,
                width: 280,
                height: 280,
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

  void _showInformation(BuildContext context) {
    showDialog(
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
                'Informações sobre ${widget.title}',
                style: TextStyle(
                    fontSize: 16.0,
                    color: state.themeData.colorScheme.secondary),
              ),
              content: Text(
                widget.description,
                style: TextStyle(
                    fontSize: 14.0,
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

  // Editando a tela inicial com o campo de áudio
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeState>(
      listener: (context, state) {
        context.read<ThemeCubit>().state;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: state.themeData.colorScheme.onSurface,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      // Espaçamento na esquerda para adaptação de tamanho com Slider
                      margin: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 16,
                          color: state.themeData.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          PopupMenuButton<String>(
                            color: state.themeData.colorScheme.onSurface,
                            padding: EdgeInsets.zero,
                            tooltip: 'Mais opções',
                            icon: Icon(Icons.more_vert_rounded,
                                color: state.themeData.colorScheme.onSurface),
                            itemBuilder: (context) => [
                              // Opções de dentro do botão
                              PopupMenuItem<String>(
                                value: 'image',
                                child: Text(
                                  'Mostrar Imagem',
                                  style: TextStyle(
                                    color:
                                        state.themeData.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'info',
                                child: Text(
                                  'Mostrar Informações',
                                  style: TextStyle(
                                    color:
                                        state.themeData.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ],
                            // Caso um dos botões seja pressionado, uma ação é executada
                            onSelected: (value) {
                              // Função para mostrar a imagem ou as informações
                              switch (value) {
                                case 'image':
                                  _showImage(context);
                                case 'info':
                                  _showInformation(context);
                              }
                            },
                          ),
                          IconButton(
                            // Botão de iniciar o áudio
                            key: const Key('play_pause_btn'),
                            onPressed: _isPlaying ? _pause : _play,
                            padding: EdgeInsets.zero,
                            tooltip: _isPlaying ? 'Pausar' : 'Reproduzir',
                            iconSize: 24.0,
                            icon: _isPlaying
                                ? const Icon(Icons.pause_rounded)
                                : const Icon(Icons.play_arrow_rounded),
                            color: state.themeData.colorScheme.onSurface,
                          ),
                          IconButton(
                            // Botão de parar a reprodução de áudio
                            key: const Key('stop_btn'),
                            onPressed: _isPlaying || _isPaused ? _stop : _stop,
                            padding: EdgeInsets.zero,
                            tooltip: 'Parar',
                            iconSize: 24.0,
                            icon: const Icon(Icons.stop_rounded),
                            color: state.themeData.colorScheme.onSurface,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Slider(
                  // Slider que mostra qual parte do áudio está sendo tocado
                  activeColor: state.themeData.colorScheme.onSurface,
                  inactiveColor: state.themeData.colorScheme.onSurface,
                  onChanged: (value) {
                    // Variável que recebe a duração do áudio
                    final duration = _duration;
                    if (duration == null) {
                      return;
                    }
                    // Variável que recebe o momento do áudio em milisegundos
                    final position = value * duration.inMilliseconds;
                    widget.player
                        .seek(Duration(milliseconds: position.round()));
                  },
                  // Casos de segurança para definir o valor
                  // quando o mesmo for alterado no simulador
                  value: (_position != null &&
                          _duration != null &&
                          _position!.inMilliseconds > 0 &&
                          _position!.inMilliseconds < _duration!.inMilliseconds)
                      ? _position!.inMilliseconds / _duration!.inMilliseconds
                      : 0.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
