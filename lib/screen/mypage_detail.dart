import 'package:catch0/provider/AuthProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../utils/app_text_styles.dart';
import 'login.dart';
import 'mypage.dart';

class mypage_detail extends StatefulWidget {
  const mypage_detail({Key? key}) : super(key: key);

  @override
  _mypage_detailState createState() => _mypage_detailState();
}

class _mypage_detailState extends State<mypage_detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset("assets/icons/icon_back.png"),
          onPressed: (){
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text('마이페이지',style: titleMedium.copyWith(color: Colors.black),),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Center(
              child: Container(
                child: Column(
                  children: [
                    ClipOval(
                      clipper: MyClipper(),
                      child: Image.asset('assets/images/2.jpeg',
                          height: 90.w,
                          fit : BoxFit.fitWidth),
                    ),
                    SizedBox(height: 20.h),
                    Text('${user} 님', style: titleMedium),
                    Text("${FirebaseAuth.instance.currentUser!.email}", style: labelSmall),
                  ],
                ),
              ),
            ),
            SizedBox(height: 43.h,),
            Row(
              children: [
                Text('내 정보 수정', style: titleSmall),
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
            SizedBox(height: 20.h),
            Row(
              children: [
                Text('결제 및 계좌 정보 수정', style: titleSmall),
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
            SizedBox(height: 20.h),
            Row(
              children: [
                Text('약관 및 개인정보 처리', style: titleSmall),
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
            SizedBox(height: 20.h),
            Divider(height:1),
            SizedBox(height: 20.h),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(52.w, 20.h),
              ),
                onPressed: (){
                  context.read<AuthProvider>().signOut(context);
                  Get.to(() => Login());
                },
                child:Text('로그아웃', style: titleSmall.copyWith(color:Colors.black))
            ),

            SizedBox(height: 20.h),
            Text('탈퇴하기', style: labelSmall),
          ],
        )
      )
    );
  }
}

class MyClipper extends CustomClipper<Rect>{

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 90.w, 90.w);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
