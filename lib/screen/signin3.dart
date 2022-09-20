import 'package:catch0/screen/signin4.dart';
import 'package:catch0/screen/todaycatch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../provider/AuthProvider.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widget/sigininWidget.dart';


class Signin3 extends StatefulWidget {
  const Signin3({Key? key}) : super(key: key);

  @override
  _Signin3State createState() => _Signin3State();
}

class _Signin3State extends State<Signin3> {

  // TextEditingController emailController = Get.arguments['email'];
  // TextEditingController passwordController = Get.arguments['pw'];
  final TextEditingController nicknameController = TextEditingController();

  // void signUpUser() async {
  //   context.read<AuthProvider>().signUpWithEmail(
  //     email: emailController.text,
  //     password: passwordController.text,
  //     nickname: nicknameController.text,
  //     context: context,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          signinWidget(
            Title: "사용자 닉네임",
            subTitle: "닉네임을 만들어주세요.\n닉네임을 건너뛰실 시 ‘Catcher’로 지정됩니다.",
            // hintText: "닉네임을 입력해주세요.",
            percent: 1,
            pagenum: '3/3',
          ),

          Container(
            width: 327.w,
            height: 40.h,

            child: TextFormField(
              controller: nicknameController,

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

                hintText: "닉네임 입력해주세요.",
                hintStyle: textTheme.button!.copyWith(color: Colors.black.withOpacity(0.4)),
              ),
            ),
          ),

          SizedBox(
            height: 70.h,
          ),

          ElevatedButton(
            onPressed: (){
              setState(() {
                if(nicknameController.text.isEmpty) {
                  nicknameController.text = 'Catcher';
                }
              });
              Get.to(() => Signin4(), arguments: {"email": Get.arguments['email'], "pw": Get.arguments['pw'], "nickname":nicknameController});
            },
            child: Text(
              "다음",
              style: titleMedium.copyWith(
                color: Colors.white,
              ),
            ),
            style: ButtonStyle(

                fixedSize: MaterialStateProperty.all(Size(327.w, 40.h)),
                backgroundColor: MaterialStateProperty.all(
                  primary[40],
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
          Padding(
            padding: EdgeInsets.zero,
            child: TextButton(
              onPressed: (){
                Get.to(() => Signin4(), arguments: {"email": Get.arguments['email'], "pw": Get.arguments['pw'], "nickname":nicknameController});
              },
              child: Text('건너뛰기',
                  style: labelMedium.copyWith(color: primary[40])
              ),
            ),
          ),
        ],
      ),

    );
  }
}
