import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/use_cases/pokemon/get_pokemon_use_case.dart';
import '../state/pokemon_ui_state.dart';
import '../../config/use_case_config.dart';

final useCaseConfigProvider = Provider((ref) => UseCaseConfig());

final pokemonProvider = StateNotifierProvider<PokemonNotifier, PokemonUiState>((ref) {
  final useCase = ref.watch(useCaseConfigProvider).getPokemonUseCase;
  return PokemonNotifier(useCase);
});

class PokemonNotifier extends StateNotifier<PokemonUiState> {
  final GetPokemonUseCase _getPokemonUseCase;

  PokemonNotifier(this._getPokemonUseCase) : super(const PokemonUiState.initial());

  Future<void> loadPokemons() async {
    state = const PokemonUiState.loading();
    try {
      final pokemons = await _getPokemonUseCase.getAllPokemon();
      state = PokemonUiState.loaded(pokemons);
    } catch (e) {
      state = PokemonUiState.error(e.toString());
    }
  }

  Future<void> loadPokemonById(int id) async {
    state = const PokemonUiState.loading();
    try {
      final pokemon = await _getPokemonUseCase.getPokemonById(id);
      state = PokemonUiState.loaded([pokemon]);
    } catch (e) {
      state = PokemonUiState.error(e.toString());
    }
  }
}