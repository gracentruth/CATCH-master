import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class notFound extends StatefulWidget {
  const notFound({Key? key}) : super(key: key);

  @override
  _notFoundState createState() => _notFoundState();
}

class _notFoundState extends State<notFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 130.h,),
            Image.asset('assets/images/emoticon.png',),
            SizedBox(height: 60.h,),
            Text("이 기능은 개발 중에 있습니다.\n빠른 시일 내에 공개하도록 하겠습니다.\n너른 이해 감사드립니다.",
              style: titleSmall.copyWith(color:Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h,),
            ElevatedButton(
              onPressed: () async {
                Get.back();
              },
              child: Text(
                "이전 화면으로 돌아가기",
                style: titleSmall.copyWith(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(

                  fixedSize: MaterialStateProperty.all(Size(180.w, 40.h)),
                  backgroundColor: MaterialStateProperty.all(
                    primary[40],
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )
                  ),
                  side: MaterialStateProperty.all(
                    BorderSide(
                        width: 0,
                        color: primary[0]!.withOpacity(0.02)
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
