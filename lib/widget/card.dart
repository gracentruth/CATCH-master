import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class cardwidget extends StatefulWidget {
  const cardwidget({Key? key,
    required this.ID,
    required this.title,
    required this.cash,
    required this.percent,
    required this.daysdue,
    required this.category,
    required this.participate}) : super(key: key);

  final String ID;
  final String title;
  final String cash;
  final String percent;
  final String daysdue;
  final List category;
  final int participate;

  @override
  _cardwidgetState createState() => _cardwidgetState();
}

class _cardwidgetState extends State<cardwidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270.h,
      width: 327.w,
      child: Card(
          surfaceTintColor: onErrorColor,
          margin: EdgeInsets.only(bottom: 21.h),
          shape: RoundedRectangleBorder(
            //모서리를 둥글게 하기 위해 사용
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4.0,
          //그림자 깊이
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/logo2.png",
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(width: 5.w),
                    Text(widget.ID, style: labelMedium.copyWith(color:primary[0]!.withOpacity(0.5))),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(Icons.more_vert),
                            onPressed: (){},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                Text(widget.title, style: titleMedium.copyWith(color:Colors.black)),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    if(widget.participate == 1)
                      
                      Container(
                        width: 44.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF00D796),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('참여중', style: labelSmall.copyWith(color:Colors.white)),
                          ],
                        ),
                      ),
                    // Chip(
                    //     label: SizedBox(
                    //         height: 15.h,
                    //         child: Text('참여중', style: labelMedium.copyWith(color:Colors.white))
                    //     ),
                    //     padding: const EdgeInsets.all(4.0),
                    //     backgroundColor: Color(0xFF00D796)
                    // ),
                    SizedBox(width: 5.w),
                    Text(widget.cash, style: labelLarge.copyWith(color:primary[40])),
                    Text('  캐시', style: labelLarge.copyWith(color:Colors.black)),
                  ],
                ),
                SizedBox(height: 18.h),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(int i = 0; i<widget.category.length; i++)
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Chip(
                          label: Text(widget.category[i], style: labelMedium),
                          onDeleted: () {
                            setState(() {
                              print("bla");
                            });
                          },
                          deleteIcon: Icon(
                            Icons.close,
                            size: 8.w,
                          ),
                          backgroundColor: Color(0xFFF3F4F5),
                        ),
                    ),

                  ],
                ),
                SizedBox(height: 18.h),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    value: int.parse(widget.percent)*0.01,
                    minHeight: 8.h,
                    valueColor: AlwaysStoppedAnimation(primary[50]),
                    backgroundColor: primary[0]!.withOpacity(0.05),
                  ),
                ),

                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(widget.percent, style: labelLarge.copyWith(color:primary[50])),
                    Text('%', style: labelLarge.copyWith(color:primary[50])),
                    Text('달성', style: labelMedium.copyWith(color:Colors.black)),

                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(widget.daysdue, style: labelSmall.copyWith(color:primary[0]!.withOpacity(0.4))),
                            Text('일 후 마감', style: labelSmall.copyWith(color:primary[0]!.withOpacity(0.4))),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
