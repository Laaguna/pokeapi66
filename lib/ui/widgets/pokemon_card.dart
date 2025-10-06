import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi66/ui/widgets/pokemon_type_chips.dart';

import '../../domain/models/pokemon/pokemon.dart';
import '../helpers/utils/utils.dart';
import '../pages/detail/pokemon_detail_page.dart';
import '../providers/favorites_provider.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final WidgetRef ref;

  // Constructor para recibir los datos necesarios
  const PokemonCard({
    Key? key,
    required this.pokemon,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final typeColor = getTypeColor(pokemon.types.first.type.name);
    final typeHighlightColor = getTypeHighlightColor(pokemon.types.first.type.name);
    final isFavorite = ref.watch(favoritesProvider.select((favorites) =>
        favorites.contains(pokemon.id)
    ));

    return Container(
      decoration: BoxDecoration(
        color: typeColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PokemonDetailPage(pokemon: pokemon),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 0, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'N°${pokemon.id.toString().padLeft(3, '0')}',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,

                        ),
                      ),

                      Text(
                        pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      PokemonTypeChips(
                        types: pokemon.types,
                        getTypeIcon: getTypeIcon,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: typeHighlightColor.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Center( // centra el container pequeño
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            // decoration: BoxDecoration(
                            //   image: DecorationImage(
                            //     image: AssetImage(getTypeImage(pokemon.types.first.type.name)),
                            //     fit: BoxFit.contain,
                            //     colorFilter: ColorFilter.mode(
                            //       getTypeHighlightColor(pokemon.types.first.type.name).withOpacity(0.15),
                            //       BlendMode.srcATop,
                            //     ),
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    ),


                    Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.network(
                            pokemon.sprites.frontDefault ?? '',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          ref.read(favoritesProvider.notifier).toggle(pokemon.id);
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                        ),
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
