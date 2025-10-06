import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:pokeapi66/domain/models/pokemon/gateway/pokemon_gateway.dart';
import 'package:pokeapi66/domain/models/pokemon/pokemon.dart';
import 'package:pokeapi66/domain/use_cases/pokemon/get_pokemon_use_case.dart';

import 'get_pokemon_use_case_test.mocks.dart';

Pokemon createTestPokemon({int id = 1, String name = 'bulbasaur'}) {
  return Pokemon(
    id: id,
    name: name,
    baseExperience: 64,
    height: 7,
    weight: 69,
    abilities: [],
    types: [],
    stats: [],
    sprites: const PokemonSprites(
      frontDefault: null,
      backDefault: null,
      frontShiny: null,
      backShiny: null,
    ),
  );
}

@GenerateMocks([PokemonGateway])
void main() {
  late GetPokemonUseCase useCase;
  late MockPokemonGateway mockGateway;

  setUp(() {
    mockGateway = MockPokemonGateway();
    useCase = GetPokemonUseCase(mockGateway);
  });

  group('GetPokemonUseCase', () {
    test('should get pokemon by id from gateway', () async {
      final testPokemon = createTestPokemon(id: 1, name: 'bulbasaur');


      when(mockGateway.getPokemonById(1))
          .thenAnswer((_) async => testPokemon);


      final result = await useCase.getPokemonById(1);


      expect(result, testPokemon);
      verify(mockGateway.getPokemonById(1)).called(1);
    });

    test('should get all pokemon from gateway', () async {
      final testPokemons = [
        createTestPokemon(id: 1, name: 'bulbasaur'),
        createTestPokemon(id: 2, name: 'ivysaur'),
        createTestPokemon(id: 3, name: 'venusaur'),
      ];


      when(mockGateway.getAllPokemon())
          .thenAnswer((_) async => testPokemons);


      final result = await useCase.getAllPokemon();


      expect(result, testPokemons);
      expect(result.length, 3);
      verify(mockGateway.getAllPokemon()).called(1);
    });

    test('should propagate error when gateway fails', () async {

      when(mockGateway.getPokemonById(999))
          .thenThrow(Exception('Pokemon not found'));


      expect(() => useCase.getPokemonById(999), throwsException);
    });
  });
}