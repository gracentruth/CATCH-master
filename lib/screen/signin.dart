import 'package:catch0/provider/AuthProvider.dart';
import 'package:catch0/screen/signin2.dart';
import 'package:catch0/screen/todaycatch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widget/sigininWidget.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // bool _isValidEmail(String val) {
  //   return RegExp(r'^010\d{7,8}$').hasMatch(val);
  // }

  bool isButtonActive = false;

  void initState(){
    super.initState();
    emailController.addListener(() {
      //final isButtonActive = emailController.text.isNotEmpty;
      final isButtonActive = validateEmail();
      setState(() {
        this.isButtonActive = isButtonActive;
        print(isButtonActive);
      });
    });
  }

  bool validateEmail() {
    var value = emailController.text;
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return false;
    else
      return true;
  }
  // dispose it when the widget is unmounted
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // final PageController controller =
    // PageController(initialPage: 0, viewportFraction: 1.0);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body:
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                signinWidget(
                  Title: "이메일",
                  subTitle: "계정에 사용하실 이메일을 입력해주세요.\n이메일은 마이페이지에서 수정 가능합니다.",
                  percent: 0.33,
                  pagenum: '1/3',
                ),

                Container(
                  width: 327.w,
                  height: 40.h,

                  child: TextFormField(
                    key: _formKey,
                    controller: emailController,
                    // validator: (value){
                    //   RegExp regExp = new RegExp(
                    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                    //     caseSensitive: false,
                    //     multiLine: false,
                    //   );
                    //   if (value == null || value.isEmpty)
                    //     return '이메일을 입력하세요';
                    //   else if (!regExp.hasMatch(value)) {
                    //     return '이메일 형식이 일치하지 않습니다';
                    //   }
                    // },

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
                  height: 12.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("이메일 형식으로 작성해주세요",
                    style: labelMedium.copyWith(color: isButtonActive? Colors.white.withOpacity(0) :errorColor),),
                  ],
                ),

                SizedBox(
                  height: 44.h,
                ),


            ElevatedButton(
              onPressed: isButtonActive ? () async {
                  setState(() {
                    isButtonActive = false;
                    // emailController.clear();
                  });
                  Get.to(() => Signin2(), arguments: emailController);

              } : null,
                child: Text(
                  "다음",
                  style: titleMedium.copyWith( color: isButtonActive? Colors.white : primary[0]?.withOpacity(0.4),),
                ),

                style: ButtonStyle(

                    fixedSize: MaterialStateProperty.all(Size(327.w, 40.h)),
                    backgroundColor: MaterialStateProperty.all(
                      isButtonActive? primary[40] : primary[0]?.withOpacity(0.2),
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
          ),

    );
  }
}

///
///



//3

