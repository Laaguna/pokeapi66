import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi66/ui/widgets/pokemon_info_chip.dart';
import 'package:pokeapi66/ui/widgets/pokemon_type_chips.dart';
import '../../../domain/models/pokemon/pokemon.dart';
import '../../helpers/utils/utils.dart';

class PokemonDetailPage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final colorType = getTypeColor(pokemon.types.first.type.name);

    final ability = pokemon.abilities.isNotEmpty
        ? pokemon.abilities.first.ability.name
        : 'Desconocida';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.01 ),
              height: MediaQuery.of(context).size.height * 0.42,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -MediaQuery.of(context).size.width * 0.4,
                    left: -MediaQuery.of(context).size.width * 0.4,
                    right: -MediaQuery.of(context).size.width * 0.4,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 1.1,
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        color: colorType.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.width * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(getTypeImage(pokemon.types.first.type.name)),
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                getTypeHighlightColor(pokemon.types.first.type.name).withOpacity(0.15),
                                BlendMode.srcATop,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),


                  Positioned(
                    top: 60,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  Positioned(
                    bottom: 1,
                    child: Transform.translate(
                      offset: const Offset(0, -5),
                      child: Transform.scale(
                        scale: 1.3,
                        child: Image.network(
                          pokemon.sprites.frontDefault ?? '',
                          height: MediaQuery.of(context).size.width * 0.5,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  ),

                ],
              ),
            ),


           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 16),
             child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:[
                       Text(
                         pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
                         style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                           fontWeight: FontWeight.bold,
                           fontSize: 48,
                         ),
                       ),
                       Text(
                         'N°${pokemon.id.toString().padLeft(3, '0')}',
                         style: const TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w500),
                       ),
                     ]
                   ),

                   PokemonTypeChips(
                     types: pokemon.types,
                     getTypeIcon: getTypeIcon,
                   ),

                   Text(
                     'Tiene una semilla de planta en la espalda desde que nace. La semilla crece lentamente.',
                     textAlign: TextAlign.left,
                     style: TextStyle(
                       color: Colors.grey[700],
                       fontSize: 16,
                       fontWeight: FontWeight.w400,
                     ),
                   ),

                   const Divider(height: 1),

                   GridView.count(
                     crossAxisCount: 2,
                     shrinkWrap: true,
                     crossAxisSpacing: 16,
                     mainAxisSpacing: 16,
                     physics: const NeverScrollableScrollPhysics(),
                     childAspectRatio: 2.5,
                     children: [
                       PokemonInfoChip(
                         label: 'Peso',
                         value: '${(pokemon.weight / 10).toStringAsFixed(1)} kg',
                         icon: CupertinoIcons.bag_fill,
                       ),
                       PokemonInfoChip(
                         label: 'Altura',
                         value: '${(pokemon.height / 10).toStringAsFixed(1)} m',
                         icon: CupertinoIcons.arrow_up_arrow_down,
                       ),
                       const PokemonInfoChip(
                         label: 'Categoría',
                         value: 'Semilla',
                         icon: CupertinoIcons.square_grid_2x2,
                       ),
                       PokemonInfoChip(
                         label: 'Habilidad',
                         value: ability[0].toUpperCase() + ability.substring(1),
                         icon: Icons.catching_pokemon_outlined,
                       ),
                     ],
                   ),

                   // Column(
                   //   crossAxisAlignment: CrossAxisAlignment.start,
                   //   children: [
                   //     const Text(
                   //       'Debilidades',
                   //       style: TextStyle(
                   //           fontWeight: FontWeight.bold, letterSpacing: 1.2),
                   //     ),
                   //     const SizedBox(height: 12),
                   //     PokemonTypeChips(
                   //         types: types,
                   //         getTypeIcon: getTypeIcon
                   //     )
                   //   ],
                   // ),
                 ].separated(const SizedBox(height: 24)),
             )
           ),

          ],
        ),
      ),
    );
  }

}


