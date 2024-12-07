part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  // Classe contendo instância de temas do aplicativo
  final ThemeData themeData;
  // Construtor padrão
  const ThemeState({
    required this.themeData,
  });

  // Criação da classe contendo valores iniciais
  factory ThemeState.initial() {
    return ThemeState(themeData: themes[0]);
  }

  // Propriedade que identificará se duas instâncias são iguais
  @override
  List<Object> get props => [themeData];

  @override
  String toString() => "ThemeState{themeData: $themeData}";

  // Função para gerenciar o estado da instância das classes
  ThemeState copyWith({
    required ThemeData? themeData,
  }) {
    return ThemeState(
      // Mantém os valores caso sejam iguais, se não, a troca é feita
      themeData: themeData ?? this.themeData,
    );
  }
}
