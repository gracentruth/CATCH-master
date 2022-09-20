
//
import 'package:catch0/provider/AuthProvider.dart';
import 'package:catch0/screen/signin.dart';
import 'package:catch0/screen/todaycatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'findPw.dart';
import 'home.dart';
import 'notFound.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser(){
    AuthProvider(FirebaseAuth.instance).loginWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context
    );
  }

  var _isChecked = false;

  // String _id = '';
  // String _pw = '';
  // late SharedPreferences _prefs;
  //

  // String initialSignatureText = 'Sent from Mail.';
  // var signatureText;
  //
  // void convertSignature(){
  //   String convertedSignature = emailController.text;
  //   setSignature(convertedSignature);
  // }
  // void setSignature(String convertedSignature) async{
  //   SharedPreferences signPrefs = await SharedPreferences.getInstance();
  //   signPrefs.setString('signatureTextKey', convertedSignature);
  // }
  // Future<String> getSignature() async {
  //   SharedPreferences signPrefs = await SharedPreferences.getInstance();
  //   signatureText = signPrefs.get('signatureTextKey');
  //   return signatureText;
  // }
  //
  // void initState() {
  //   super.initState();
  //   getSignature();
  //
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     emailController.text = await getSignature();
  //   });
  // }

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(24.w, 0.h, 24.w, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
          Container(
          padding: EdgeInsets.fromLTRB(80.w, 184.h, 80.w, 0),
          child: Image.asset('assets/images/catch_logo.png',
              height: 30.w,
              fit : BoxFit.fitWidth),
          ),

          SizedBox(
            height: 61.h,
          ),

                Container(
                  width: 327.w,
                  height: 40.h,

                  child: TextFormField(
                    controller: emailController,

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

                      hintText: "이메일",
                     hintStyle: textTheme.button!.copyWith(color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                ),
        SizedBox(
          height: 10.h,
        ),

                Container(
                  width: 327.w,
                  height: 40.h,

                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
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

                      hintText: "비밀번호",
                      hintStyle: textTheme.button!.copyWith(color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                ),

      Padding(
        padding: EdgeInsets.fromLTRB(0, 10.h, 15.w, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Row(
               children: [
                 Checkbox(
                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)
                    ),
                    activeColor: primary[40],
                    checkColor: _isChecked ? Colors.white : primary[0]?.withOpacity(0.4),
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                        // if(_isChecked = true) {
                        //
                        // }
                      });
                    },
                  ),

                  Text("로그인 유지",
                      style: labelLarge.copyWith(color:Colors.black.withOpacity(0.4))
                  ),
               ],
             ),
            // SizedBox(width: 69.w),
            TextButton(
              style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(135.w, 20.h),
                ),
                onPressed: (){
                  Get.to(() => findPw());
                  // Get.to(() => findPw());
                },
                child: Text("로그인 정보를 잊으셨나요?",
                    style: labelLarge.copyWith(color: Color(0xff2C63BB))
                )
            )
          ],
        ),
      ),

      SizedBox(
        height: 20.h,
      ),

      ElevatedButton(
          // onPressed: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) {
          //     return home(cameras);
          //   }));
          // },
          onPressed: () async {
            try {
              // await FirebaseAuth.instance.signInWithEmailAndPassword(
              //   email: emailController.text,
              //   password: passwordController.text,
              // );
              loginUser();

            } on FirebaseAuthException catch (e) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('로그인 오류'),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('확인')
                        )
                      ],
                    );
                  }
              );
            }
          },
          child: Text(
            "로그인",
            style: titleMedium.copyWith(
              color: Colors.white,
            ),
          ),
          style: ButtonStyle(
              fixedSize:
              MaterialStateProperty.all(Size(327.w, 40.h)),
              backgroundColor: MaterialStateProperty.all(
                primary[40],
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )
              ),
              side: MaterialStateProperty.all(
                BorderSide(
                  width: 0,
                ),
              )),
        ),


      SizedBox(height: 30.h,),

      Container(
        height:1.h,
        width:340.w,
        color: primary[0]?.withOpacity(0.05),
      ),

      Container(
        padding: EdgeInsets.fromLTRB(0, 30.h, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset('assets/icons/google_icon.png'),
              iconSize: 50.w,
              onPressed: (){
                AuthProvider(FirebaseAuth.instance).signInWithGoogle(context);
              }
            ),
            SizedBox(width: 10.w),
            IconButton(
              icon: Image.asset('assets/icons/apple_icon.png'),
              iconSize: 50.w,
              onPressed: () {},
            )
          ],
        ),
      ),

      SizedBox(height: 20.h,),


      Text("계정이 없으신가요?", style: labelLarge.copyWith(color: Colors.black.withOpacity(0.4))),


     TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Signin();
              }));
            },
            child: Text("회원가입",
                style: labelLarge.copyWith(color: Color(0xff2C63BB))
            ),
          ),

      ],
    ),
    ),
    ),
    );
  }
}
