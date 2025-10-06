import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, -2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          indicatorColor: Colors.transparent,
          selectedIndex: selectedIndex,
          onDestinationSelected: onItemSelected,
          destinations: [
            _buildDestination(Icons.home, 'Pokédex', 0, selectedIndex),
            _buildDestination(Icons.favorite, 'Favoritos', 1, selectedIndex),
            _buildDestination(Icons.person, 'Perfil', 2, selectedIndex),
          ],
        ),
      ),
    );
  }

  NavigationDestination _buildDestination(
      IconData icon,
      String label,
      int index,
      int selectedIndex,
      ) {
    final bool selected = selectedIndex == index;
    return NavigationDestination(
      icon: Icon(
        icon,
        color: selected ? Colors.blueAccent : Colors.grey,
      ),
      label: label,
    );
  }
}
