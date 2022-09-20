import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class buttonWidget extends StatefulWidget {
  const buttonWidget({Key? key}) : super(key: key);

  @override
  _buttonWidgetState createState() => _buttonWidgetState();
}

class _buttonWidgetState extends State<buttonWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child:ElevatedButton(
        onPressed: () async {

        },
        child: Text(
          "다음",
          style: titleMedium.copyWith(
            color: primary[0]?.withOpacity(0.4),
          ),
        ),
        style: ButtonStyle(
            fixedSize:
            MaterialStateProperty.all(Size(327.w, 40.h)),
            backgroundColor: MaterialStateProperty.all(
              primary[0]?.withOpacity(0.2),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )
            ),
            side: MaterialStateProperty.all(
              BorderSide(
                width: 0,
              ),
            )),
      ),
    );
  }
}
