import 'package:flutter/material.dart';
import '../../../domain/models/pokemon/pokemon.dart';

class PokemonDetailPage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
      ),
      body: Center(
        child: Text('Detalle de ${pokemon.name}'),
      ),
    );
  }
}