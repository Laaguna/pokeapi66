import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi66/ui/helpers/utils/utils.dart';

class PokemonInfoChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const PokemonInfoChip({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.black.withOpacity(0.6),
            ),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.6),
                letterSpacing: 0.5,
              ),
            ),
          ].separated(const SizedBox(width: 6)),
        ),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ].separated(const SizedBox(height: 8)),
    );
  }
}
