import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapi66/ui/widgets/custom_bottom_bar.dart';
import '../../helpers/utils/utils.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/pokemon_provider.dart';
import '../../providers/filter_provider.dart';
import '../../widgets/filter_bottom_sheet.dart';
import '../../widgets/pokemon_card.dart';
import '../favorites/favorites_page.dart';
import '../detail/pokemon_detail_page.dart';

class PokemonListPage extends ConsumerStatefulWidget {
  const PokemonListPage({super.key});

  @override
  ConsumerState<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends ConsumerState<PokemonListPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(pokemonProvider.notifier).loadPokemons());
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      _buildPokemonList(),
      const FavoritesPage(),
      _buildProfileView(),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildPokemonList() {
    final pokemonState = ref.watch(pokemonProvider);
    final filteredPokemons = ref.watch(filteredPokemonsProvider);
    final currentFilters = ref.watch(filterProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return pokemonState.when(
      initial: () => const Center(child: Text('Cargando...')),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (pokemons) {
        var displayPokemons = filteredPokemons.isEmpty ? pokemons : filteredPokemons;

        // Filtrar por búsqueda
        if (searchQuery.isNotEmpty) {
          displayPokemons = displayPokemons.where((p) =>
              p.name.toLowerCase().contains(searchQuery.toLowerCase())
          ).toList();
        }

        final filterCount = currentFilters?.length ?? 0;

        return Column(
          children: [
            // Barra de búsqueda y filtro
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // 🔹 Campo de búsqueda
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        ref.read(searchQueryProvider.notifier).state = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Procurar Pokémon...',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50), // Máximo redondeo
                          borderSide: const BorderSide(color: Colors.grey, width: 1.2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.grey, width: 1.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  Badge.count(
                    count: filterCount,
                    isLabelVisible: filterCount > 0,
                    backgroundColor: Colors.redAccent,
                    textColor: Colors.white,
                    offset: const Offset(4, -4),
                    child: IconButton(
                      onPressed: () => _showFilterBottomSheet(context),
                      icon: const Icon(Icons.filter_list, color: Colors.black87),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: Colors.grey, width: 1.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ],
              )

            ),

            // Texto de resultados
            if (displayPokemons.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Se han encontrado ${displayPokemons.length} resultados',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

            if (filterCount > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      ref.read(filterProvider.notifier).state = null;
                    },
                    child: const Text('Borrar filtro'),
                  ),
                ),
              ),

            const SizedBox(height: 8),

            // Lista de Pokemon
            Expanded(
              child: displayPokemons.isEmpty
                  ? const Center(child: Text('No hay pokémon disponibles'))
                  : RefreshIndicator(
                onRefresh: () => ref.read(pokemonProvider.notifier).loadPokemons(),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: displayPokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = displayPokemons[index];
                    return PokemonCard(pokemon: pokemon, ref: ref);
                  },
                ),
              ),
            ),
          ],
        );
      },
      error: (message) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text('Error: $message'),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => ref.read(pokemonProvider.notifier).loadPokemons(),
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }



  void _showFilterBottomSheet(BuildContext context) {
    final currentFilters = ref.read(filterProvider) ?? <String>[];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FilterBottomSheet(
          currentFilters: currentFilters,
          ref: ref,
        );
      },
    );
  }


  Widget _buildProfileView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 80,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Perfil de Usuario',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
