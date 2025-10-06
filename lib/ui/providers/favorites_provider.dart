import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi66/ui/providers/pokemon_provider.dart';

import '../../domain/models/pokemon/pokemon.dart';

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<int>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<int>> {
  FavoritesNotifier() : super([]);

  void toggle(int pokemonId) {
    if (state.contains(pokemonId)) {
      state = state.where((id) => id != pokemonId).toList();
    } else {
      state = [...state, pokemonId];
    }
  }

  bool isFavorite(int pokemonId) => state.contains(pokemonId);
}

final favoritePokemonsProvider = Provider<List<Pokemon>>((ref) {
  final pokemonState = ref.watch(pokemonProvider);
  final favoriteIds = ref.watch(favoritesProvider);

  return pokemonState.when(
    initial: () => <Pokemon>[],
    loading: () => <Pokemon>[],
    loaded: (pokemons) {
      // Filtrar los Pokemon que están en la lista de favoritos
      return pokemons.where((pokemon) =>
          favoriteIds.contains(pokemon.id)
      ).toList();
    },
    error: (_) => <Pokemon>[],
  );
});