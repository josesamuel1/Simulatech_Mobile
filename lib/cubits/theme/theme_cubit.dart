import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'themes.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void changeTheme() {
    // Armazena o índice do tema atual
    final currentIndex = themes.indexOf(state.themeData);
    // Armazena o próximo índice a ser usado
    // % -> Garante que o índice retorne ao início caso a lista acabe
    final nextIndex = (currentIndex + 1) % themes.length;
    // Emite um novo estado para o tema com o índice do próximo tema
    emit(state.copyWith(themeData: themes[nextIndex]));
  }
}
