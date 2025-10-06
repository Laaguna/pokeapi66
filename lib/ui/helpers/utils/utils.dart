import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color getTypeColor(String type) {
  final colors = {
    'fire': const Color(0x80FF9800),
    'water': const Color(0x984A90E2),
    'grass': const Color(0x808BC34A),
    'electric': const Color(0x80FFCE4B),
    'psychic': const Color(0x80F85888),
    'normal': const Color(0x80A8A878),
    'fighting': const Color(0x80C03028),
    'flying': const Color(0x80A890F0),
    'poison': const Color(0x80A040A0),
    'ground': const Color(0x80E0C068),
    'rock': const Color(0x80B8A038),
    'bug': const Color(0x80A8B820),
    'ghost': const Color(0x80705898),
    'steel': const Color(0x80B8B8D0),
    'dragon': const Color(0x807038F8),
    'dark': const Color(0x80705848),
    'fairy': const Color(0x80EE99AC),
    'ice': const Color(0x8098D8D8),
  };
  return colors[type.toLowerCase()] ?? const Color(0x80A8A878);
}

Color getTypeHighlightColor(String type) {
  final colors = {
    'fire': const Color(0xFFFF9800),
    'water': const Color(0xFF4A90E2),
    'grass': const Color(0xFF8BC34A),
    'electric': const Color(0xFFFFCE4B),
    'psychic': const Color(0xFFF85888),
    'normal': const Color(0xFFA8A878),
    'fighting': const Color(0xFFC03028),
    'flying': const Color(0xFFA890F0),
    'poison': const Color(0xFFA040A0),
    'ground': const Color(0xFFE0C068),
    'rock': const Color(0xFFB8A038),
    'bug': const Color(0xFFA8B820),
    'ghost': const Color(0xFF705898),
    'steel': const Color(0xFFB8B8D0),
    'dragon': const Color(0xFF7038F8),
    'dark': const Color(0xFF705848),
    'fairy': const Color(0xFFEE99AC),
    'ice': const Color(0xFF98D8D8),
  };
  return colors[type.toLowerCase()] ?? const Color(0xFFA8A878);
}

IconData getTypeIcon(String type) {
  final icons = {
    'fire': Icons.local_fire_department,
    'water': Icons.water_drop,
    'grass': Icons.eco,
    'electric': Icons.bolt,
    'psychic': Icons.psychology,
    'normal': Icons.circle,
    'poison': Icons.science,
    'ground': Icons.terrain,
    'flying': Icons.air,
    'bug': Icons.bug_report,
  };
  return icons[type.toLowerCase()] ?? Icons.circle;
}

String getTypeImage(String type) {
  final images = {
    'fire': 'assets/types/fire.png',
    'water': 'assets/types/water.png',
    'grass': 'assets/types/grass.png',
    'electric': 'assets/types/electric.png',
    'psychic': 'assets/types/psychic.png',
    'normal': 'assets/types/normal.png',
    'poison': 'assets/types/poison.png',
    'ground': 'assets/types/ground.png',
    'flying': 'assets/types/flying.png',
    'bug': 'assets/types/bug.png',
  };

  return images[type.toLowerCase()] ?? 'assets/types/normal.png';
}

extension SeparatedExtension on List<Widget> {
  List<Widget> separated(Widget separator) {
    if (isEmpty) return [];
    return [
      for (int i = 0; i < length; i++) ...[
        this[i],
        if (i < length - 1) separator,
      ]
    ];
  }
}



