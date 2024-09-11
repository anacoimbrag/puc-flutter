import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:puc_flutter_virtual/home_page.dart';
import 'package:puc_flutter_virtual/profile_page.dart';
import 'package:puc_flutter_virtual/search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var cameras = await availableCameras();
  if (cameras.isNotEmpty) {
    final usedCamera = cameras.first;
    runApp(MainApp(camera: usedCamera));
  } else {
    runApp(HomePage());
  }
}

class MainApp extends StatefulWidget {
  MainApp({super.key, required this.camera});

  CameraDescription camera;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late CameraController _controller;
  late Future<void> _initializer;

  String imagePath = '';

  @override
  void initState() {
    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _initializer = _controller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nosso primeiro app',
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Câmera'),
          ),
          body: FutureBuilder(
            future: _initializer,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(children: [
                  CameraPreview(_controller),
                  if (imagePath.isNotEmpty) Image.network(imagePath)
                ]);
              } else {
                return Center(
                  child: Image.asset("images/loading.gif"),
                );
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _takePicture(),
            child: Icon(Icons.photo_camera),
          ),
        ),
      ),
    );
  }

  _takePicture() async {
    try {
      final image = await _controller.takePicture();
      setState(() {
        imagePath = image.path;
      });
    } catch (e) {
      print('erro ao tirar foto: $e');
    }
  }
}
