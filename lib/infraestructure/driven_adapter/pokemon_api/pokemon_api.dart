import 'package:dio/dio.dart';
import 'package:pokeapi66/domain/models/pokemon/pokemon.dart';
import 'package:pokeapi66/domain/models/pokemon/gateway/pokemon_gateway.dart';
import 'package:pokeapi66/infraestructure/helpers/pokemon_mapper.dart';

class PokemonApi extends PokemonGateway {
  final Dio _dio;

  PokemonApi(this._dio);

  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  @override
  Future<List<Pokemon>> getAllPokemon() async {
    final response = await _dio.get('$_baseUrl/pokemon?offset=0&limit=50');

    final results = response.data['results'] as List;

    final pokemons = await Future.wait(
      results.map((e) async {
        final pokemonDetail = await _dio.get(e['url']);
        return PokemonMapper.fromJson(pokemonDetail.data);
      }),
    );

    return pokemons;
  }

  @override
  Future<Pokemon> getPokemonById(int id) async {
    final response = await _dio.get('$_baseUrl/pokemon/$id');
    return PokemonMapper.fromJson(response.data);
  }
}