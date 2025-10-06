import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/pokemon/pokemon.dart';
import '../../widgets/error_widget.dart';

class ProfilePage extends StatelessWidget {

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
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