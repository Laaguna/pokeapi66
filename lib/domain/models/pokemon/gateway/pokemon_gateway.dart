import '../pokemon.dart';


abstract class PokemonGateway {
  Future<Pokemon> getPokemonById(int id);
  Future<List<Pokemon>> getAllPokemon();
}