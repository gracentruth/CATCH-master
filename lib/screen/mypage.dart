import 'package:catch0/screen/mypage_detail.dart';
import 'package:catch0/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/app_colors.dart';

String user='';
int cash = 0;

class mypage extends StatefulWidget {
  const mypage({Key? key}) : super(key: key);

  @override
  State<mypage> createState() => _mypageState();
}

class _mypageState extends State<mypage> {

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot ds){
      setState(() {
        user = ds['name'].toString();
        cash = ds['cash'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('마이페이지',style: titleMedium.copyWith(color: Colors.black),),
        elevation: 0,
        // backgroundColor: primary[0]?.withOpacity(0.02),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return mypage_detail();
                }));
              },
              child: Row(
                children: [
                  ClipOval(
                    clipper: MyClipper(),
                    child: Image.asset('assets/images/2.jpeg',
                                        height: 70.w,
                                        fit : BoxFit.fitWidth),
                  ),
                  SizedBox(width: 15.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${user} 님', style: titleMedium),
                      Text("${FirebaseAuth.instance.currentUser!.email}", style: labelSmall),
                    ],
                  ),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.arrow_forward_ios)
                          ]
                      )
                  )

                ],
              ),
            ),
            SizedBox(height: 45.w,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/setting.png',
                        height: 30.w,
                        fit : BoxFit.fitWidth),
                    SizedBox(height:7),
                    Text('설정', style: labelMedium)
                  ],
                ),
                SizedBox(width: 60.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/mywriting.png',
                        height: 30.w,
                        fit : BoxFit.fitWidth),
                    SizedBox(height:7),
                    Text('내가 쓴 글', style: labelMedium)
                  ],
                ),
                SizedBox(width: 48.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/money.png',
                        height: 30.w,
                        fit : BoxFit.fitWidth),
                    SizedBox(height:7),
                    Row(
                      children: [
                        Text('캐시 ', style: labelMedium),
                        SizedBox(width: 2.w),
                        Text('$cash', style: labelMedium)
                      ],
                    )

                  ],
                ),
              ],
            ),
            SizedBox(height: 50.h,),
            Row(
              children: [
                Text('도움말', style: titleSmall),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            color: Color(0xFFCFD2D9),
                            onPressed: (){

                            },
                            icon: Icon(Icons.navigate_next),
                          ),
                        ]
                    )
                )
              ],
            ),
            SizedBox(height: 20.h,),
            Divider(height:1),
            SizedBox(height: 20.h,),
            Row(
              children: [
                Text('공지사항', style: titleSmall),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            color: Color(0xFFCFD2D9),
                            onPressed: (){

                            },
                            icon: Icon(Icons.navigate_next),
                          ),
                        ]
                    )
                )
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              children: [
                Text('FAQ', style: titleSmall),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            color: Color(0xFFCFD2D9),
                            onPressed: (){

                            },
                            icon: Icon(Icons.navigate_next),
                          ),
                        ]
                    )
                )
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              children: [
                Text('문의하기', style: titleSmall),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        color: Color(0xFFCFD2D9),
                        onPressed: (){

                        },
                        icon: Icon(Icons.navigate_next),
                      ),
                    ]
                  )
                )
              ],
            ),
            SizedBox(height: 20.h,),
            Divider(height:1),
            SizedBox(height: 20.h,),
            Row(
              children: [
                Text('앱 버전 0.5', style: titleSmall)
              ],
            ),
          ],
        ),
      )

    );
  }
}

class MyClipper extends CustomClipper<Rect>{

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 70.w, 70.w);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}