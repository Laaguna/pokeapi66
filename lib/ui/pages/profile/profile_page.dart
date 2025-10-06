import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/pokemon/pokemon.dart';

class ProfilePage extends StatelessWidget {

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const  Center(
        child: const Text('User Profile'),
      ),
    );
  }
}