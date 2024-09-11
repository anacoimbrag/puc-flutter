import 'package:flutter/material.dart';
import 'package:puc_flutter_virtual/bottom_navigation.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('Voltar a tela'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigation(),
    );
  }
}
