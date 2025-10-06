import 'package:flutter_test/flutter_test.dart';
import 'package:pokeapi66/domain/models/pokemon/pokemon.dart';
import 'package:pokeapi66/infraestructure/helpers/named_resource_mapper.dart';

void main() {
  group('NamedResourceMapper', () {
    test('should map json to NamedResource correctly', () {

      final json = {
        'name': 'overgrow',
        'url': 'https://pokeapi.co/api/v2/ability/65/',
      };


      final result = NamedResourceMapper.fromJson(json);


      expect(result, isA<NamedResource>());
      expect(result.name, 'overgrow');
      expect(result.url, 'https://pokeapi.co/api/v2/ability/65/');
    });

    test('should handle empty strings', () {

      final json = {
        'name': '',
        'url': '',
      };


      final result = NamedResourceMapper.fromJson(json);


      expect(result.name, '');
      expect(result.url, '');
    });
  });
}