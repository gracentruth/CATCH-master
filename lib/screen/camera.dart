import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool take = false;
List<int> counting = [0,0,0];

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    required this.camera,
  });

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // 카메라의 현재 출력물을 보여주기 위해 CameraController를 생성합니다.
    _controller = CameraController(
      // 이용 가능한 카메라 목록에서 특정 카메라를 가져옵니다.
      widget.camera,
      // 적용할 해상도를 지정합니다.
      ResolutionPreset.medium,
    );

    // 다음으로 controller를 초기화합니다. 초기화 메서드는 Future를 반환합니다.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
    _controller.dispose();
    super.dispose();
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(take.toString())),
      // 카메라 프리뷰를 보여주기 전에 컨트롤러 초기화를 기다려야 합니다. 컨트롤러 초기화가
      // 완료될 때까지 FutureBuilder를 사용하여 로딩 스피너를 보여주세요.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Future가 완료되면, 프리뷰를 보여줍니다.
            return Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_controller)),

                take?Container(
                  child: Text('찍는중 '),
                  //color:Colors.blueAccent,
                  decoration: BoxDecoration(
                      color:Colors.blueAccent.withOpacity(0.5)
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ):Container(),
                Positioned(
                    top: 47.h,
                    left: 21.w,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.flash_off_rounded,
                            color: Colors.white,
                            size: 26.w,
                          ),
                          onPressed: () {
                            print('clicked');
                          },
                        ),
                        SizedBox(width: 30.w),
                        IconButton(
                          icon: Icon(
                            Icons.cameraswitch_sharp,
                            color: Colors.white,
                            size: 26.w,
                          ),
                          onPressed: () {
                            print('clicked');
                          },
                        ),
                      ],
                    )),
                Positioned(
                    left: 100,
                    top: 300,
                    child: Column(
                      children: [
                        Text(take?'찍는중':'No', style: TextStyle(color: Colors.white)),
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(50), //모서리를 둥글게
                              border:
                              Border.all(color: Colors.white, width: 5)),
                        ),
                      ],
                    )),
                Positioned(
                  child: SizedBox(
                    width: 90,
                    child: take?Container():FloatingActionButton(
                      shape: CircleBorder(),
                      focusColor: Colors.white,
                      clipBehavior: Clip.hardEdge,
                      child: Icon(
                        Icons.circle,
                        size: 50,
                      ),
                      // onPressed 콜백을 제공합니다.
                      onPressed: () async {

                        take=true;
                        print(take);
                        setState(() {});
                        // try / catch 블럭에서 사진을 촬영합니다. 만약 뭔가 잘못된다면 에러에
                        // 대응할 수 있습니다.
                        try {
                          // 카메라 초기화가 완료됐는지 확인합니다.
                          await _initializeControllerFuture;

                          XFile file = await _controller.takePicture();

                          String fileName = 'test/${DateTime.now()}.png';
                          File imageFile = File(file.path);

                          try {
                            String fileUrl = await (await storage.ref(fileName).putFile(imageFile)).ref.getDownloadURL();

                            if('카테고리 이름!' == '~~')
                              counting[0] ++;

                            if('카테고리 이름!' == '~~')
                              counting[1] ++;

                            if('카테고리 이름!' == '~~')
                              counting[2] ++;

                            FirebaseFirestore.instance.collection('category').doc('카테고리 이름 !').set({
                              'new': fileUrl,
                              'category': '카테고리 이름 !',
                            }).then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));

                          } on FirebaseException catch (error) {
                            if (kDebugMode) {
                              print(error);
                            }
                          }
                          //await Future.delayed(Duration(seconds: 1));
                          take=false;
                          print(take);
                          setState(() {});
                        } catch (e) {
                          // 만약 에러가 발생하면, 콘솔에 에러 로그를 남깁니다.
                          print(e);
                        }
                      },
                    ),
                  ),
                  bottom: 30,
                  right: 150,
                )
              ],
            );
          } else {
            // 그렇지 않다면, 진행 표시기를 보여줍니다.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}