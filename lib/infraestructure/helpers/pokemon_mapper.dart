import 'package:pokeapi66/domain/models/pokemon/pokemon.dart';
import 'package:pokeapi66/infraestructure/helpers/named_resource_mapper.dart';

class PokemonMapper {
  static Pokemon fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      baseExperience: json['base_experience'],
      height: json['height'],
      weight: json['weight'],
      abilities: (json['abilities'] as List)
          .map((e) => PokemonAbility(
        isHidden: e['is_hidden'],
        slot: e['slot'],
        ability: NamedResourceMapper.fromJson(e['ability']),
      ))
          .toList(),
      types: (json['types'] as List)
          .map((e) => PokemonType(
        slot: e['slot'],
        type: NamedResourceMapper.fromJson(e['type']),
      ))
          .toList(),
      stats: (json['stats'] as List)
          .map((e) => PokemonStat(
        stat: NamedResourceMapper.fromJson(e['stat']),
        effort: e['effort'],
        baseStat: e['base_stat'],
      ))
          .toList(),
      sprites: PokemonSprites(
        frontDefault: json['sprites']['front_default'],
        backDefault: json['sprites']['back_default'],
        frontShiny: json['sprites']['front_shiny'],
        backShiny: json['sprites']['back_shiny'],
      ),
    );
  }
}