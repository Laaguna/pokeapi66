import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi66/ui/widgets/error_widget.dart';

import '../../providers/favorites_provider.dart';
import '../../widgets/pokemon_card.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePokemons = ref.watch(favoritePokemonsProvider);

    if (favoritePokemons.isEmpty) {
      return const Center(
        child: ErrorStateWidget(
          canRetry: false,
          title: 'No has marcado ningún Pokémon como favorito',
          description: 'Haz clic en el ícono de corazón de tus Pokémon favoritos y aparecerán aquí.',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Favoritos'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        padding: const EdgeInsets.all(16),
        itemCount: favoritePokemons.length,
        itemBuilder: (context, index) {
          final pokemon = favoritePokemons[index];
          return PokemonCard(pokemon: pokemon, ref:ref);
        },
      ),
    );
  }
}