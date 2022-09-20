import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../provider/AuthProvider.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class Signin4 extends StatefulWidget {
  const Signin4({Key? key}) : super(key: key);

  @override
  _Signin4State createState() => _Signin4State();
}

class _Signin4State extends State<Signin4> {
  final TextEditingController emailController = Get.arguments['email'];
  final TextEditingController passwordController = Get.arguments['pw'];
  final TextEditingController nicknameController = Get.arguments['nickname'];

  void signUpUser() async {
    context.read<AuthProvider>().signUpWithEmail(
      email: emailController.text,
      password: passwordController.text,
      nickname: nicknameController.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SizedBox(height: 160.h,),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
            child: Image.asset('assets/images/cacher.gif',),
          ),
          // SizedBox(height: 20.h,),
          Text("${nicknameController.text} 님,\nCatch에 오신 걸 환영합니다.",
          textAlign: TextAlign.center,
          style: titleLarge.copyWith(color: black),),
          SizedBox(height: 50.h,),
          ElevatedButton(
            onPressed: signUpUser,
            child: Text(
              "가입 완료하기",
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
        ],
      ),
    );
  }
}
