import 'package:flutter/material.dart';
import 'package:puc_flutter_virtual/bottom_navigation.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu perfil'),
      ),
      body: const Center(
        child: Text('Página de perfil'),
      ),
      bottomNavigationBar: const MyBottomNavigation(),
    );
  }
}
