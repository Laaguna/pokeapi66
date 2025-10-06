import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filter_provider.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<String> currentFilters;
  final WidgetRef ref;

  const FilterBottomSheet({
    Key? key,
    required this.currentFilters,
    required this.ref,
  }) : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late List<String> selectedFilters;

  @override
  void initState() {
    super.initState();
    selectedFilters = List<String>.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    final types = [
      'Agua', 'Dragón', 'Eléctrico', 'Hada', 'Fantasma', 'Fuego',
      'Hielo', 'Lucha', 'Normal', 'Planta', 'Psíquico', 'Roca',
      'Siniestro', 'Tierra', 'Veneno', 'Volador'
    ];

    final typeMapping = {
      'Agua': 'water',
      'Dragón': 'dragon',
      'Eléctrico': 'electric',
      'Hada': 'fairy',
      'Fantasma': 'ghost',
      'Fuego': 'fire',
      'Hielo': 'ice',
      'Lucha': 'fighting',
      'Normal': 'normal',
      'Planta': 'grass',
      'Psíquico': 'psychic',
      'Roca': 'rock',
      'Siniestro': 'dark',
      'Tierra': 'ground',
      'Veneno': 'poison',
      'Volador': 'flying',
    };

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
                const Text(
                  'Filtra por tus preferencias',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Tipo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...types.map((type) {
                  final typeKey = typeMapping[type]!;
                  final isSelected = selectedFilters.contains(typeKey);

                  return CheckboxListTile(
                    title: Text(type),
                    value: isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedFilters.add(typeKey);
                        } else {
                          selectedFilters.remove(typeKey);
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                  );
                }).toList(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      widget.ref.read(filterProvider.notifier).state =
                      selectedFilters.isEmpty ? null : selectedFilters;
                      Navigator.pop(context);
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Aplicar'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
