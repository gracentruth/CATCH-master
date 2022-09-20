import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class textffwidget extends StatefulWidget {
  const textffwidget({Key? key, required this.hinttext,this.contentPadding}) : super(key: key);
  final String hinttext;
  final EdgeInsets? contentPadding;

  @override
  _textffwidgetState createState() => _textffwidgetState();
}

class _textffwidgetState extends State<textffwidget> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return TextFormField(
      style: textTheme.labelLarge!,
      decoration: InputDecoration(
        hintText: widget.hinttext,
        hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
          border: InputBorder.none,
        contentPadding: widget.contentPadding
      ),
    );
  }
}

//EdgeInsets.fromLTRB(5.w, 20.h, 0.w, 20.h),


// class textbuttonwidget extends StatefulWidget {
//   const textbuttonwidget({Key? key, required this.hinttext}) : super(key: key);
//   final String hinttext;
//
//   @override
//   _textbuttonwidgetState createState() => _textbuttonwidgetState();
// }
//
// class _textbuttonwidgetState extends State<textffwidget> {
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return TextButton(
//       onPressed: ,
//       child: ,
//     );
//   }
// }
