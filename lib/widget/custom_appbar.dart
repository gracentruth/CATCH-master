import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key, required this.totalcash}) : preferredSize = Size.fromHeight(78.h), super(key: key);

  @override
  final Size preferredSize;
  final String totalcash;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 40.w,),
              Image.asset('assets/images/catch_logo.png', height: 22.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Image.asset('assets/icons/cash_icon.png', width: 20.w, height: 22.h,),
                    onPressed: () {  },
                  ),
                  Text(widget.totalcash,
                    style: labelMedium.copyWith(color:primary[50]))
                ],
              ),
            ],
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}