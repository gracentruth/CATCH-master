import 'dart:ffi';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math' as math;
import 'package:tflite/tflite.dart';
import '../main.dart';
import 'bndbox.dart';
import 'camera2.dart';
import 'models.dart';
import 'package:flutter/rendering.dart';

typedef convert_func = Pointer<Uint32> Function(Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Int32, Int32, Int32, Int32);
typedef Convert = Pointer<Uint32> Function(Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, int, int, int, int);

var globalKey = new GlobalKey();

class TakePictureScreen2 extends StatefulWidget {
  @override
  _TakePictureScreen2State createState() => new _TakePictureScreen2State();
}

class _TakePictureScreen2State extends State<TakePictureScreen2> {
  List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = '';
  late CameraController controller;
  late Future<void> _initializeControllerFuture;

  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    onSelect(ssd);
    controller = new CameraController(
      cameras[0],
      ResolutionPreset.low,
    );
  }


  loadModel() async {
    String? res;
    res = await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite",
        labels: "assets/ssd_mobilenet.txt");
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState((){
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:Colors.transparent
      ),
      body:
      _model == ""
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
          ],
        ),
      )
          :
      Stack(
        children: [
          if (cameras != null)
            Camera2(
              cameras,
              _model,
              setRecognitions,
            ),
          BndBox(
              _recognitions == null ? [] : _recognitions,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width,
              _model),
        ],
      ),
    );
  }
}