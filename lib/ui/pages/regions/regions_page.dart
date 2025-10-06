import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi66/ui/widgets/error_widget.dart';

class RegionsPage extends StatelessWidget {

  const RegionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const  Center(
        child: ErrorStateWidget(
          canRetry: false,
          imagePath: 'assets/images/coming_soon.png',
          title: '¡Muy pronto disponible!',
          description: 'Estamos trabajando para traerte esta sección. Vuelve más adelante para descubrir todas las novedades.',
        ),
      ),
    );
  }
}