import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi66/ui/providers/pokemon_provider.dart';
import '../../domain/models/pokemon/pokemon.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final filterProvider = StateProvider<List<String>?>((ref) => null);

final filteredPokemonsProvider = Provider<List<Pokemon>>((ref) {
  final pokemonState = ref.watch(pokemonProvider);
  final filters = ref.watch(filterProvider);

  return pokemonState.when(
    initial: () => <Pokemon>[],
    loading: () => <Pokemon>[],
    loaded: (pokemons) {
      // Si no hay filtros, devolver todos los Pokemon
      if (filters == null || filters.isEmpty) return pokemons;

      // Filtrar Pokemon que tengan al menos uno de los tipos seleccionados
      return pokemons.where((pokemon) {
        return pokemon.types.any((typeInfo) =>
            filters.contains(typeInfo.type.name.toLowerCase())
        );
      }).toList();
    },
    error: (_) => <Pokemon>[],
  );
});