import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widget/sigininWidget.dart';
import 'login.dart';

class findPw2 extends StatefulWidget {
  const findPw2({Key? key}) : super(key: key);

  @override
  _findPw2State createState() => _findPw2State();
}

class _findPw2State extends State<findPw2> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        resizeToAvoidBottomInset : false,
        body: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("비밀번호 재설정 메일이\n발송되었습니다.\n입력해주신 메일을 확인해주세요.",
              style: titleLarge.copyWith(color: black),
                textAlign: TextAlign.center,),

              SizedBox(
                height: 48.h,
              ),

              ElevatedButton(
                onPressed: () async {
                  Get.to(() => Login());

                  // Get.to(() => Signin2(), arguments: emailController);

                },
                child: Text(
                  "로그인으로 돌아가기",
                  style: titleMedium.copyWith( color:  Colors.white,),
                ),

                style: ButtonStyle(

                    fixedSize: MaterialStateProperty.all(Size(327.w, 40.h)),
                    backgroundColor: MaterialStateProperty.all(
                        primary[40]
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
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
        )
    );
  }
}
