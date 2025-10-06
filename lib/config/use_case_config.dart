

import 'package:dio/dio.dart';
import 'package:pokeapi66/domain/use_cases/pokemon/get_pokemon_use_case.dart';
import 'package:pokeapi66/infraestructure/driven_adapter/pokemon_api/pokemon_api.dart';


class UseCaseConfig {
  late final Dio _dio;
  late final PokemonApi _pokemonApi;
  late final GetPokemonUseCase getPokemonUseCase;

  UseCaseConfig() {
    _dio = Dio();
    _pokemonApi = PokemonApi(_dio);
    getPokemonUseCase = GetPokemonUseCase(_pokemonApi);
  }
}