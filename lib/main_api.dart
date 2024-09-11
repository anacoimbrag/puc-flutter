import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:puc_flutter_virtual/home_page.dart';
import 'package:puc_flutter_virtual/model/photo.dart';

import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: _fetchPhotos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: Text(snapshot.data?.elementAt(index).title ?? ''),
                  leading: Image.network(
                      snapshot.data?.elementAt(index).thumbnailUrl ?? ''),
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<List<Photo>> _fetchPhotos() async {
    var response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .map((element) => Photo.fromJson(element))
          .toList();
    } else {
      throw Exception('Não foi possível carregar os dados');
    }
  }
}
