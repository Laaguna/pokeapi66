import 'package:flutter/material.dart';
import 'package:pokeapi66/ui/helpers/utils/utils.dart';

class PokemonTypeChips extends StatelessWidget {
  final List<dynamic> types; // Lista de tipos (pokemon.types)
  final IconData Function(String typeName) getTypeIcon; // Función para íconos

  const PokemonTypeChips({
    Key? key,
    required this.types,
    required this.getTypeIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: types.map<Widget>((t) {
        final name = t.type.name;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: getTypeHighlightColor(name),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white, // círculo blanco
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  getTypeImage(name),
                  width: 20,
                  height: 20,
                  color: getTypeHighlightColor(name), // opcional si quieres tintar la imagen
                ),
              ),

              const SizedBox(width: 4),
              Text(
                name[0].toUpperCase() + name.substring(1),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
