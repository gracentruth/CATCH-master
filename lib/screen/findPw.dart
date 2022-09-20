import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widget/sigininWidget.dart';
import 'findPw2.dart';
import 'login.dart';

class findPw extends StatefulWidget {
  const findPw({Key? key}) : super(key: key);

  @override
  _findPwState createState() => _findPwState();
}

class _findPwState extends State<findPw> {
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
            children: [
              findIdPwWidget(
                Title: "비밀번호를 잊으셨나요?",
                subTitle: "이메일을 입력하시면\n비밀번호 재설정 메일을 보내드립니다.",
              ),
              Container(
                width: 327.w,
                height: 40.h,

                child: TextFormField(
                  controller: emailController,
                  validator: (value){
                    RegExp regExp = new RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                      caseSensitive: false,
                      multiLine: false,
                    );
                    if (value == null || value.isEmpty)
                      return '이메일을 입력하세요';
                    else if (!regExp.hasMatch(value)) {
                      return '이메일 형식이 일치하지 않습니다';
                    }
                  },

                  style: bodyMedium,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15.w, 7.h, 15.w, 7.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36.w),
                      // borderSide: BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.02),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(36.w)),
                      borderSide: BorderSide(width: 3,color: primary[0]!.withOpacity(0.02)),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(36.w)),
                      borderSide: BorderSide(width: 3,color: primary[0]!.withOpacity(0.02)),
                    ),

                    hintText: "이메일을 입력해주세요.",
                    hintStyle: textTheme.button!.copyWith(color: Colors.black.withOpacity(0.4)),
                  ),
                ),
              ),

              SizedBox(
                height: 20.h,
              ),

              ElevatedButton(
                onPressed: resetPassword,

                child: Text(
                  "다음",
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

              SizedBox(
                height: 20.h,
              ),

              TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(135.w, 20.h),
                  ),
                  onPressed: (){
                    // Get.to(() => notFound());
                    Get.to(() => Login());
                  },
                  child: Text("로그인으로 돌아가기",
                      style: labelLarge.copyWith(color: Color(0xff2C63BB))
                  )
              )



            ],
          ),
        )
    );
  }


  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Get.to(() => findPw2());
    } on FirebaseAuthException catch (e){
      print(e);
      Navigator.of(context).pop();
    }
  }


}
