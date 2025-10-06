import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filter_provider.dart';
import '../../ui/helpers/utils/utils.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tipo',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Icon(
                          Icons.keyboard_arrow_up_outlined,
                          color: Colors.grey,
                          size: 30,
                        )

                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(1),
                    child: Divider(height: 1),
                  ),

                  Column(
                    children: types.map((type) {
                      final typeKey = typeMapping[type]!;
                      final isSelected = selectedFilters.contains(typeKey);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedFilters.remove(typeKey);
                            } else {
                              selectedFilters.add(typeKey);
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                type,
                                style: const TextStyle(fontSize: 16),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: CupertinoColors.separator,
                                    width: 1.5,
                                  ),
                                ),
                                child: isSelected
                                    ? const Icon(
                                  CupertinoIcons.check_mark,
                                  color: CupertinoColors.white,
                                  size: 16,
                                )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            Column(
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
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                        'Aplicar',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                  ),
                ),
              ].separated(const SizedBox(height: 8))
                  .addToStart(const SizedBox(height: 8)),
            ),
          ].separated(const SizedBox(height: 8)),
        ),
      )
    );
  }
}
