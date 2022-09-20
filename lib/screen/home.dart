import 'dart:ffi';

import 'package:catch0/screen/catchbox_detail.dart';
import 'package:catch0/screen/catchme.dart';
import 'package:catch0/screen/tflite.dart';
import 'package:catch0/screen/todaycatch.dart';
import 'package:catch0/screen/todaycatch_detail.dart';
import 'package:catch0/screen/transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tflite/tflite.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:catch0/utils/app_colors.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors.dart';
import 'camera.dart';
import 'camera2.dart';
import 'camera_load.dart';
import 'catchbox.dart';
import 'catchbox_detail.dart';
import 'login.dart';
import 'mypage.dart';

List<CameraDescription> cameras = [];
typedef convert_func = Pointer<Uint32> Function(Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Int32, Int32, Int32, Int32);
typedef Convert = Pointer<Uint32> Function(Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, int, int, int, int);

var globalKey = new GlobalKey();

class home extends StatefulWidget {
  const home(List<CameraDescription> cameras, {Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
/*
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey key = GlobalKey();
  GlobalKey _key1 = GlobalKey();
  GlobalKey _key2 = GlobalKey();
  GlobalKey _key3 = GlobalKey();
*/
  List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  late CameraController controller;
  late Future<void> _initializeControllerFuture;

  FirebaseStorage storage = FirebaseStorage.instance;

  int _currentIndex = 0;
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // loadModel() async {
  //   try {
  //     String res;
  //     res = (await Tflite.loadModel(
  //       model: "assets/model/model_unquant.tflite",
  //       labels: "assets/model/labels.txt",
  //     ))!;
  //     print(res);
  //   } on PlatformException {
  //     print("Failed to load the model");
  //   }
  // }

  loadModel() async {
    String? res;
    res = await Tflite.loadModel(
        model: "assets/ssd_mobilenet.tflite",
        labels: "assets/ssd_mobilenet.txt");
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  void initCamera() async{
    cameras = await availableCameras();
  }

  @override
  void initState() {
    super.initState();

    loadModel();
    initCamera();
  }
//TakePictureScreen2()
  final List<Widget> _children = [todaycatch(),catchme(),CamerLoad(),Catchbox(), mypage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: primary[0]?.withOpacity(0.02),
        body: _children[_currentIndex],
        bottomNavigationBar: Container(
          height: 83.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Color(0xff101D3F).withOpacity(.1), spreadRadius: 0, blurRadius: 20),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/Home_de.png', width: 20.w, height: 22.h,),
                  activeIcon: Image.asset('assets/icons/Home.png', width: 20.w, height: 22.h,),
                  label: '오늘의 캐치',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/Catchme_de.png', width: 20.w, height: 22.h,),
                  activeIcon: Image.asset('assets/icons/Catchme.png', width: 20.w, height: 22.h,),
                  label: '캐치미',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/Camera_de.png', width: 20.w, height: 22.h,),
                  label: '카메라',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/Picture_de.png', width: 20.w, height: 22.h,),
                  activeIcon: Image.asset('assets/icons/Picture.png', width: 20.w, height: 22.h,),
                  label: '캐치박스',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/My_de.png', width: 20.w, height: 22.h,),
                  activeIcon: Image.asset('assets/icons/My.png', width: 20.w, height: 22.h,),
                  label: '마이페이지',
                ),
              ],
              currentIndex: _currentIndex,
              selectedItemColor: Colors.blueAccent[40],
              unselectedItemColor: Colors.black54.withOpacity(.60),
              onTap: _onTap,
            ),
          ),
        ));
  }
}




// class _homeState extends State<home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Column(
//             children: [
//               SizedBox(height:60),
//               TextButton(
//                   onPressed: (){
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Transaction(cameras),)
//                     );
//                   },
//                   child: Text('haeun',
//                     style: TextStyle(fontFamily: 'NotoSansKR'),)
//               ),
//               TextButton(
//                   onPressed: (){
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Transaction(cameras),)
//                     );
//                   },
//                   child: Text('yuri',
//                     style: TextStyle(fontFamily: 'NotoSansKR'),)
//               ),
//               TextButton(
//                   onPressed: (){
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Transaction(cameras))
//                     );
//                   },
//                   child: Text('gyugyeong')
//               ),
//               TextButton(
//                   onPressed: (){
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Transaction(cameras),)
//                     );
//                   },
//                   child: Text('eunjin')
//               ),
//             ],
//           )
//       ),
//     );
//   }
//
// }
