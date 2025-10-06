import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/pokemon/pokemon.dart';

part 'pokemon_ui_state.freezed.dart';

@freezed
class PokemonUiState with _$PokemonUiState {
  const factory PokemonUiState.initial() = _Initial;
  const factory PokemonUiState.loading() = _Loading;
  const factory PokemonUiState.loaded(List<Pokemon> pokemons) = _Loaded;
  const factory PokemonUiState.error(String message) = _Error;
}