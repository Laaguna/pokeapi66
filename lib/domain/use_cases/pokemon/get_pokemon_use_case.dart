

import '../../models/pokemon/gateway/pokemon_gateway.dart';
import '../../models/pokemon/pokemon.dart';

class GetPokemonUseCase {
  final PokemonGateway _pokemonGateway;

  GetPokemonUseCase(this._pokemonGateway);

  Future<Pokemon> getPokemonById(int id) async {
    return _pokemonGateway.getPokemonById(id);
  }

  Future<List<Pokemon>> getAllPokemon() async {
    return _pokemonGateway.getAllPokemon();
  }
}