import 'dart:io';
import 'package:catch0/screen/tflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'bndbox.dart';
import 'models.dart';
import 'package:image/image.dart' as imglib;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:catch0/utils/app_colors.dart';

typedef void Callback(List<dynamic> list, int h, int w);

String object = '';
late CameraImage savedImage;
bool take = false;
bool isSwitched = true;

late dynamic memoryImage;
Uint8List imagelist = Uint8List(10000000);
CameraImage? result;
int a = 0;
List<int> counting = [0, 0, 0];

class Camera2 extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;

  Camera2(this.cameras, this.model, this.setRecognitions);

  @override
  _Camera2State createState() => new _Camera2State();
}

class _Camera2State extends State<Camera2> {
  late CameraController controller;
  bool isDetecting = false;

  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    if (widget.cameras == null || widget.cameras.length < 1) {
      if (kDebugMode) {
        print('No camera is found');
      }
    } else {
      controller = CameraController(
        widget.cameras[0],
        ResolutionPreset.ultraHigh,
      );
      controller.initialize().then((_) async {
        if (!mounted) {
          return;
        }
        //setState(() {});
        controller.startImageStream((CameraImage image) async {
          _processCameraImage(image);
          if (!isDetecting) {
            isDetecting = true;
            int startTime = new DateTime.now().millisecondsSinceEpoch;
            Tflite.detectObjectOnFrame(
              bytesList: image.planes.map((plane) {
                return plane.bytes;
              }).toList(),
              model: "SSDMobileNet",
              imageHeight: image.height,
              imageWidth: image.width,
              imageMean: 127.5,
              imageStd: 127.5,
              numResultsPerClass: 1,
              threshold: 0.1,
              rotation: 0,
            ).then((recognitions) async {
              int endTime = new DateTime.now().millisecondsSinceEpoch;
              //print("Detection took ${endTime - startTime}");
              widget.setRecognitions(recognitions!, image.height, image.width);
              // print('^^^^^^^^^^^^object $object^^^^^^^^^^^^^');
              //await takepicture();
              // if (object == 'motorcycle' ||
              //     object == 'bus' ||
              //     object == 'traffic light' ||
              //     object == 'stop sign' ||
              //     object == 'bicycle' ||
              //     object == 'person') {
              //     await takepicture();
              // } else {
              //   print('cant send to firebase');
              // }

              //sleep(const Duration(seconds:1));

              a = a + 1;
              isDetecting = false;
            });
          }
        });
      });
    }
  }

  @override
  Future<void> takepicture() async {
    // setState(() {});
    CameraImage image = savedImage;
    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      final int uvPixelStride = image.planes[1].bytesPerPixel!;
      print("uvRowStride: " + uvRowStride.toString());
      print("uvPixelStride: " + uvPixelStride.toString());
      var img = imglib.Image(width, height); // Create Image buffer
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          final int uvIndex =
              uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
          final int index = y * width + x;
          final yp = image.planes[0].bytes[index];
          final up = image.planes[1].bytes[uvIndex];
          final vp = image.planes[2].bytes[uvIndex];
          // Calculate pixel color

          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
              .round()
              .clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          img.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
        }
      }
      imglib.PngEncoder pngEncoder = new imglib.PngEncoder(level: 0, filter: 0);
      List<int> png = pngEncoder.encodeImage(img);
      print('*********저장 전 **********');
      await storage
          .ref('tflitetest/${object}.png')
          .putData(Uint8List.fromList(png));
      take = false;
      print('*********stored**********');

      try {
        // String fileUrl = await (await storage.ref('tflitetest/$object/${object}1.png').putData(Uint8List.fromList(png))).ref.getDownloadURL();

        // if('motorcycle' == '~~')
        //   counting[0] ++;
        //
        // if('카테고리 이름!' == '~~')
        //   counting[1] ++;
        //
        // if('카테고리 이름!' == '~~')
        // if('카테고리 이름!' == '~~')
        //   counting[2] ++;

        // FirebaseFirestore.instance.collection('category').doc(object).set({
        //   'new': fileUrl,
        //   'category': object,
        // }).then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));
        //
        // FirebaseFirestore.instance.collection('category').doc(object).collection('urls').doc().set({
        //   'url': fileUrl,
        // }).then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));

      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _processCameraImage(CameraImage image) async {
    setState(() {
      savedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize!;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: RepaintBoundary(
          key: globalKey,
          child: click? Container(
            width: screenW,
            height: screenH,
            color: Colors.black.withOpacity(0.8),
            child:  Center(
                child:  Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      width:100.w,
                      height:100.w,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color:primary[40],
                        //valueColor: new AlwaysStoppedAnimation<Color>(primary),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Text('이미지 저장 중',
                      style:  TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 16 / 14,
                          letterSpacing: 0
                      ),
                    )

                  ],

                )
            ),


          ):Stack(
            children: [
              Positioned(
                  bottom : 200.h,
                  left: 147.w,
                  child: TextButton(
                    child:Text('X'),
                    onPressed: (){

                    },
                  )
              ),
            CameraPreview(controller),
              // Positioned(
              //     bottom : 96.h,
              //     left: 147.w,
              //     child:SizedBox(
              //       width: 66.w,
              //       height: 66.h,
              //       child:RawMaterialButton(
              //   onPressed: () {
              //     print('RawMaterialButton');
              //     print(isSwitched);
              //     isSwitched=!isSwitched;
              //     print(isSwitched);
              //
              //   },
              //   elevation: 2.0,
              //   fillColor: isSwitched?Colors.white:Colors.black,
              //   child:isSwitched? Icon(
              //       Icons.camera_alt_outlined,
              //       size: 35.0,
              //       color:Colors.black
              //   ):Text(
              //       'A',
              //       style:TextStyle(
              //         color: Colors.white,
              //         fontSize: 20.w,
              //       )
              //   ),
              //   padding: EdgeInsets.all(15.0),
              //   shape: CircleBorder(),
              // ),),)


              // Positioned(
              //   bottom: 200,
              //   right: 150,
              //   child: SizedBox(
              //     width: 90,
              //     child: ElevatedButton(
              //       onPressed: () {
              //         take=true;
              //         print('clickedddddd');
              //         takepicture();
              //       }, child: Icon(
              //       Icons.circle,
              //       size: 50,
              //     ),
              //
              //     ),
              //
              //   ),
              // ),
              // Positioned(
              //   bottom: 200,
              //   right: 150,
              //   child: SizedBox(
              //     width: 90,
              //     child: FloatingActionButton(
              //       shape: CircleBorder(),
              //       focusColor: Colors.white,
              //       clipBehavior: Clip.hardEdge,
              //       child: const Icon(
              //         Icons.circle,
              //         size: 50,
              //       ),
              //       // onPressed 콜백을 제공합니다.
              //       onPressed: ()  {
              //         take=true;
              //         print('clickedddddd');
              //         takepicture();
              //       //  setState(() {});
              //       },
              //     ),
              //   ),
              // )
            ],
          )),
    );
  }
}
