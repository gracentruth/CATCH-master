
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'camera2.dart';
import 'package:image/image.dart' as imglib;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:catch0/utils/app_colors.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';


bool click = false;

class BndBox extends StatefulWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  BndBox(this.results, this.previewH, this.previewW, this.screenH, this.screenW,
      this.model);

  @override
  State<BndBox> createState() => _BndBoxState();
}

class _BndBoxState extends State<BndBox> {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<Coordinates> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final cor=new Coordinates(position.latitude, position.longitude);

    return cor;
  }

  @override
  Future<void> takepicture() async {
    setState(() {});
    CameraImage image = savedImage;
    String object2=object;
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
          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
              .round()
              .clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
          img.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
        }
      }
      imglib.PngEncoder pngEncoder = new imglib.PngEncoder(level: 0, filter: 0);
      List<int> png = pngEncoder.encodeImage(img);
      final uploadTask = await storage
          .ref('tflitetest/${object2}/${object2}${DateTime.now()}.png')
          .putData(Uint8List.fromList(png));

      final url = await uploadTask.ref.getDownloadURL();
      print(url);
      //date
      try {
        await FirebaseFirestore.instance
            .collection("category")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("전체")
            .doc("date")
            .collection("date")
            .doc()
            .set({
              "url": url,
              "time": DateFormat('dd/MM/yyyy').format(DateTime.now())
        });
      } catch (e) {
        print(e);
      }

      try {
        await FirebaseFirestore.instance
            .collection("category")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection(object2)
            .doc("date")
            .collection("date")
            .doc()
            .set({
          "url": url,
          "time": DateFormat('dd/MM/yyyy').format(DateTime.now())
        });
      } catch (e) {
        print(e);
      }

      //category
      try {
        await FirebaseFirestore.instance
            .collection("category")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("category")
            .doc(object2)
            .set({
          "category": object2,
          "count": 0,
          "new": url,
          "time": DateTime.now()
        });
      } catch (e) {
        print(e);
      }

      // final snapshot = await FirebaseDatabase.instance.ref.child('users/$userId').get();
      // if (snapshot.exists) {
      //   print(snapshot.value);
      // } else {
      //   print('No data available.');
      // }

      DatabaseReference starCountRef =
      FirebaseDatabase.instance.ref('category/${FirebaseAuth.instance.currentUser!.email}/category/전체/count');
      starCountRef.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;
        print("count? ");
        print(data);
      });

      try {
        await FirebaseFirestore.instance
            .collection("category")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("category")
            .doc("전체")
            .set({
          "category": "전체",
          "count": 0,
          "new": url,
          "time": DateTime.now()
        });
      } catch (e) {
        print(e);
      }

      Coordinates cordi=await getCurrentLocation();
      //print('위도경도 ${cordi.longitude}|${cordi.latitude}');
      var address = await Geocoder.local.findAddressesFromCoordinates(cordi).then((value) async {
        var first = value.first;
        print('${first.thoroughfare}');//동 받아옴
        //place
        // try {
        //   await FirebaseFirestore.instance
        //       .collection("category")
        //       .doc(FirebaseAuth.instance.currentUser!.email)
        //       .collection(object)
        //       .doc("place")
        //       .collection("place_url")
        //       .doc()
        //       .set({
        //     "place": first.thoroughfare,
        //     "url": url
        //   });
        // } catch (e) {
        //   print(e);
        // }
        //
        // try {
        //   await FirebaseFirestore.instance
        //       .collection("category")
        //       .doc(FirebaseAuth.instance.currentUser!.email)
        //       .collection(object)
        //       .doc("place")
        //       .collection("place")
        //       .doc(first.thoroughfare)
        //       .set({
        //     "place": first.thoroughfare,
        //     "count": 0,
        //     "choose": false
        //   });
        // } catch (e) {
        //   print(e);
        // }
      });
      // print('address: $address');




      //** 전하은 화이팅
      take = false;
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBoxes() {
      setState(() {});
      object = widget.results.first["detectedClass"];
      return widget.results
          .map((re) {
            var _x = re["rect"]["x"];
            var _w = re["rect"]["w"];
            var _y = re["rect"]["y"];
            var _h = re["rect"]["h"];
            var scaleW, scaleH, x, y, w, h;
            if (widget.screenH / widget.screenW >
                widget.previewH / widget.previewW) {
              scaleW = widget.screenH / widget.previewH * widget.previewW;
              scaleH = widget.screenH;
              var difW = (scaleW - widget.screenW) / scaleW;
              x = (_x - difW / 2) * scaleW;
              w = _w * scaleW;
              if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
              y = _y * scaleH;
              h = _h * scaleH;
            } else {
              scaleH = widget.screenW / widget.previewW * widget.previewH;
              scaleW = widget.screenW;
              var difH = (scaleH - widget.screenH) / scaleH;
              x = _x * scaleW;
              w = _w * scaleW;
              y = (_y - difH / 2) * scaleH;
              h = _h * scaleH;
              if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
            }
            return Positioned(
                left: math.max(0, x),
                top: math.max(0, y),
                width: w,
                height: h,
                child: GestureDetector(
                  onTap: () async {
                    click = true;
                    setState(() {});
                    await takepicture();
                    click = false;
                  },
                  child: click
                      ? Container(child: Text(''))
                      : Container(
                          padding: EdgeInsets.only(top: 1.0, left: 1.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: click ? Colors.red : Colors.white,
                              width: 5.0,
                            ),
                          ),
                          child: Transform.rotate(
                              angle: 0 * math.pi / 180,
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Transform.rotate(
                                  angle: 0 * math.pi / 180,
                                  child:Text(
                                      "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                                      style: TextStyle(
                                          color:Colors.white,
                                          fontFamily: 'NotoSansKR',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          height: 28 / 20,
                                          letterSpacing: 0
                                      )
                                  ),

                                )
                              )),
                        ),
                ));
          })
          .toList()
          .sublist(0, 1);
    }

    print(widget.results.length);
    if (widget.results.length == 0) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),),
        width:widget.screenW,
        height:widget.screenH,
//padding: EdgeInsets.fromLTRB(100, 200, 100, 200),
        child: Center(
          child:  Container(
            width:100.w,
            height:100.w,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color:primary[40],
//valueColor: new AlwaysStoppedAnimation<Color>(primary),
            ),
          ),
        ),
      );
    }else {
      return isSwitched
          ? Stack(
              children: _renderBoxes(),
            )
          : Container();
    }
  }
}
