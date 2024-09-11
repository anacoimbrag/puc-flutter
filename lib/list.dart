import 'package:flutter/material.dart';

const allItems = [
  'flutter',
  'dart',
  'puc',
  'desenvolvimento',
  'mobile',
  'virtual'
];

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<StatefulWidget> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  var listItems = allItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Buscar por...'),
          onChanged: (value) => setState(() {
            listItems = allItems.where((item) => item.contains(value)).toList();
          }),
        ),
        Expanded(
            child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: listItems.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              listItems[index],
            ),
          ),
        ))
      ],
    );
  }
}
