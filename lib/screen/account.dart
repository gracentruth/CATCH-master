import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'home.dart';

class account extends StatefulWidget {
  const account({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 130.h,),
            Image.asset('assets/images/accountCheck.png',),
            SizedBox(height: 60.h,),
            Text("프로젝트가 업로드 되었습니다.\n입력하신 캐시를 아래 계좌로 입금해주세요.\n\n79795113807 카카오뱅크",
              style: titleSmall.copyWith(color:Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h,),
            ElevatedButton(
              onPressed: () async {
                Get.to(() => home(cameras));
              },
              child: Text(
                "확인",
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
