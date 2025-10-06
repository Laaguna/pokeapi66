// domain/models/pokemon/pokemon.dart

class Pokemon {
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final int weight;
  final List<PokemonAbility> abilities;
  final List<PokemonType> types;
  final List<PokemonStat> stats;
  final PokemonSprites sprites;

  const Pokemon({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.types,
    required this.stats,
    required this.sprites,
  });
}

class PokemonAbility {
  final bool isHidden;
  final int slot;
  final NamedResource ability;

  const PokemonAbility({
    required this.isHidden,
    required this.slot,
    required this.ability,
  });
}

class PokemonType {
  final int slot;
  final NamedResource type;

  const PokemonType({
    required this.slot,
    required this.type,
  });
}

class PokemonStat {
  final NamedResource stat;
  final int effort;
  final int baseStat;

  const PokemonStat({
    required this.stat,
    required this.effort,
    required this.baseStat,
  });
}

class PokemonSprites {
  final String? frontDefault;
  final String? backDefault;
  final String? frontShiny;
  final String? backShiny;

  const PokemonSprites({
    this.frontDefault,
    this.backDefault,
    this.frontShiny,
    this.backShiny,
  });
}

class NamedResource {
  final String name;
  final String url;

  const NamedResource({
    required this.name,
    required this.url,
  });
}
