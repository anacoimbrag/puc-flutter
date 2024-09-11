import 'package:flutter/material.dart';
import 'package:puc_flutter_virtual/bottom_navigation.dart';
import 'package:puc_flutter_virtual/list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nosso primeiro app'),
          actions: [
            IconButton(
              onPressed: () => {print("pressionei configurações")},
              icon: const Icon(Icons.settings),
            )
          ],
        ),
        body: const Column(
          children: [
            Text('Itens favoritados'),
            Expanded(child: MyList())
          ],
        ),
        bottomNavigationBar: const MyBottomNavigation());
  }
}
