import 'package:camera/camera.dart';
import 'package:catch0/screen/tflite.dart';
import 'package:catch0/screen/todaycatch_detail2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'camera.dart';
import 'catchbox.dart';
import 'catchbox2.dart';
import 'catchbox_detail2.dart';
import 'catchme.dart';
import 'mypage.dart';

class todaycatchdetail3 extends StatefulWidget {
  final QueryDocumentSnapshot query;

  todaycatchdetail3({required this.query});

  @override
  State<todaycatchdetail3> createState() => _todaycatchdetail3State(query : query);
}

class _todaycatchdetail3State extends State<todaycatchdetail3> {
  final QueryDocumentSnapshot query;
  _todaycatchdetail3State({required this.query});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('오늘의 캐치'),
        ),
        body: ListView(
            padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 32.h),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        clipper: MyClipper(),
                        child: Image.asset('assets/images/2.jpeg',
                            height: 30.w,
                            fit : BoxFit.fitWidth),
                      ),
                      SizedBox(width: 10.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Catcher', style: labelLarge),
                        ],
                      ),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.more_vert)
                              ]
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(query['title'], style: titleLarge),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      //if(query['participate'] == 1)
                      Chip(
                          label: Container(
                            height: 20.h,
                            child: Text('참여중', style: labelMedium)
                          ),
                          backgroundColor: Color(0xFF00D796)
                      ),
                      SizedBox(width: 5.w),
                      Text(query['cash'].toString(), style: titleSmall),
                      Text('캐시', style: titleSmall),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(query['content'], style: bodyMedium),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      for(int i = 0; i<query['category'].length; i++)
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Chip(
                              label: Text(query['category'][i], style: labelMedium),
                              backgroundColor: Color(0xFFF3F4F5)
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height:30.h),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: 0.04,
                      minHeight: 8.h,
                      valueColor: AlwaysStoppedAnimation(primary[50]),
                      backgroundColor: Color(0xFFF3F4F5),
                    ),
                  ),
                  SizedBox(height:10.h),
                  Row(
                    children: [
                      Text(query['percentage'].toString(), style: labelLarge),
                      Text('% 달성', style: labelLarge),
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${query['final_day'].toString()}일 후 마감', style: labelSmall)
                            ]
                        ),
                      )
                    ],
                  ),
                ],
              )
            ]
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.w, 0, 24.w, 25.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.w,
                backgroundColor: primary[40],
                child: IconButton(
                  color: white,
                  onPressed: ()async {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return catchme();
                    // }));
                    var cameras = await availableCameras();
                    var  firstCamera = cameras.first;

                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return TakePictureScreen2();
                    }));
                  },
                  icon: Icon(Icons.camera_alt_outlined),

                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                  child: FloatingActionButton(
                    backgroundColor: primary[40],
                    onPressed: () async{
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Catchbox2(query: query),));
                    },
                    child: Text('사진 업로드하기', style: titleMedium),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))
                    ),
                  ),
              )

            ],
          )


        )
    );
  }
}

class MyClipper extends CustomClipper<Rect>{

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 30.w, 30.w);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
