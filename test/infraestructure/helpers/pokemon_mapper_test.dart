import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi66/domain/models/pokemon/pokemon.dart';
import 'package:pokeapi66/infraestructure/helpers/pokemon_mapper.dart';

void main() {
  group('PokemonMapper', () {
    test('should map complete json to Pokemon correctly', () {

      final json = {
        'id': 1,
        'name': 'bulbasaur',
        'base_experience': 64,
        'height': 7,
        'weight': 69,
        'abilities': [
          {
            'is_hidden': false,
            'slot': 1,
            'ability': {
              'name': 'overgrow',
              'url': 'https://pokeapi.co/api/v2/ability/65/'
            }
          }
        ],
        'types': [
          {
            'slot': 1,
            'type': {
              'name': 'grass',
              'url': 'https://pokeapi.co/api/v2/type/12/'
            }
          }
        ],
        'stats': [
          {
            'base_stat': 45,
            'effort': 0,
            'stat': {
              'name': 'hp',
              'url': 'https://pokeapi.co/api/v2/stat/1/'
            }
          }
        ],
        'sprites': {
          'front_default': 'https://example.com/front.png',
          'back_default': 'https://example.com/back.png',
          'front_shiny': 'https://example.com/front_shiny.png',
          'back_shiny': 'https://example.com/back_shiny.png',
        }
      };


      final result = PokemonMapper.fromJson(json);


      expect(result, isA<Pokemon>());
      expect(result.id, 1);
      expect(result.name, 'bulbasaur');
      expect(result.baseExperience, 64);
      expect(result.height, 7);
      expect(result.weight, 69);
      expect(result.abilities.length, 1);
      expect(result.abilities.first.ability.name, 'overgrow');
      expect(result.types.length, 1);
      expect(result.types.first.type.name, 'grass');
      expect(result.stats.length, 1);
      expect(result.stats.first.baseStat, 45);
      expect(result.sprites.frontDefault, 'https://example.com/front.png');
    });

    test('should handle pokemon with multiple abilities and types', () {

      final json = {
        'id': 6,
        'name': 'charizard',
        'base_experience': 240,
        'height': 17,
        'weight': 905,
        'abilities': [
          {
            'is_hidden': false,
            'slot': 1,
            'ability': {'name': 'blaze', 'url': 'https://example.com/1'}
          },
          {
            'is_hidden': true,
            'slot': 3,
            'ability': {'name': 'solar-power', 'url': 'https://example.com/2'}
          }
        ],
        'types': [
          {
            'slot': 1,
            'type': {'name': 'fire', 'url': 'https://example.com/1'}
          },
          {
            'slot': 2,
            'type': {'name': 'flying', 'url': 'https://example.com/2'}
          }
        ],
        'stats': [],
        'sprites': {
          'front_default': null,
          'back_default': null,
          'front_shiny': null,
          'back_shiny': null,
        }
      };


      final result = PokemonMapper.fromJson(json);


      expect(result.abilities.length, 2);
      expect(result.abilities[1].isHidden, true);
      expect(result.types.length, 2);
      expect(result.types[1].type.name, 'flying');
    });
  });
}