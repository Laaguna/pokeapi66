
import 'package:pokeapi66/domain/models/pokemon/pokemon.dart';

class NamedResourceMapper {
  static NamedResource fromJson(Map<String, dynamic> json) {
    return NamedResource(
      name: json['name'],
      url: json['url'],
    );
  }
}