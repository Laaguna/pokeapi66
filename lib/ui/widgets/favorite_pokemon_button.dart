import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favorites_provider.dart';

class FavoriteButton extends ConsumerWidget {
  final int pokemonId;

  const FavoriteButton({
    super.key,
    required this.pokemonId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Leemos si el Pokémon actual está en favoritos
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.contains(pokemonId);

    return IconButton(
      onPressed: () {
        ref.read(favoritesProvider.notifier).toggle(pokemonId);
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
      ),
      color: isFavorite ? Colors.red : Colors.white,
    );
  }
}
