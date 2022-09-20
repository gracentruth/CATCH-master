import 'package:catch0/screen/signin3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widget/sigininWidget.dart';


class Signin2 extends StatefulWidget {
  const Signin2({Key? key}) : super(key: key);

  @override
  _Signin2State createState() => _Signin2State();
}

class _Signin2State extends State<Signin2> {
  // final TextEditingController emailController = Get.arguments;
  TextEditingController email = Get.arguments;
  final TextEditingController passwordController = TextEditingController();

  bool isButtonActive = false;
  bool obscure = true;
  Image icon = Image.asset('assets/icons/eye_inactive.png');

  void initState(){
    super.initState();

    passwordController.addListener(() {
      //final isButtonActive = passwordController.text.isNotEmpty;
      final isButtonActive = validatePassword();
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
  }

  bool validatePassword() {
    var value = passwordController.text;
    String pattern =
        r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,12}$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return false;
    else
      return true;
  }

  // dispose it when the widget is unmounted
  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body:Padding(
        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            signinWidget(
              Title: "비밀번호",
              subTitle: "계정에 사용하실 비밀번호를 입력해주세요.\n비밀번호는 마이페이지에서 수정 가능합니다.",
              // hintText: "비밀번호를 입력해주세요.",
              percent: 0.66,
              pagenum: '2/3',
            ),

            Container(
              width: 327.w,
              height: 40.h,

              child: TextFormField(
                controller: passwordController,
                obscureText: obscure,

                // validator: (value){
                // if (value == null || value.isEmpty)
                //   return '비밀번호를 입력하세요';
                // },
//Image.asset('assets/icons/eye_active');
                style: bodyMedium,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (obscure == true) {
                            obscure = false;
                            icon = Image.asset('assets/icons/eye_active.png');
                          } else {
                            obscure = true;
                            icon = Image.asset('assets/icons/eye_inactive.png');
                          }
                        });
                      },
                      icon: icon
                  ),
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

                  hintText: "비밀번호를 입력해주세요.",
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
                Text("문자와 숫자 포함 6~12자리",
                  style: labelMedium.copyWith(color: isButtonActive? Colors.white.withOpacity(0) : primary[0]?.withOpacity(0.4)),),
              ],
            ),

            SizedBox(
              height: 44.h,
            ),

            ElevatedButton(
              onPressed: isButtonActive ? () async {
                // if (_formKey.currentState!.validate()) {
                // await FirebaseAuth.instance.createUserWithEmailAndPassword(
                //     email: _emailaddressController.text,
                //     password: _passwordController.text
                // );
                // FirebaseFirestore.instance
                //     .collection('user').
                // doc(FirebaseAuth.instance.currentUser!.uid).set({
                //   'name' : _usernameController.text,
                // });
                // Navigator.push(context,
                //     MaterialPageRoute<void>(builder: (BuildContext context) {
                //       return Signin3(email:emailController, pw:passwordController);
                //     })
                // );
                // }
                setState(() {
                  isButtonActive = false;
                  // passwordController.clear();
                });

                Get.to(() => Signin3(), arguments: {"email": Get.arguments, "pw": passwordController});

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

// class User {
//   TextEditingController email;
//   TextEditingController pw;
//   User({required this.email, required this.pw});
// }