import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'buttonWidget.dart';

final _usernameController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmpasswordController = TextEditingController();
final _emailaddressController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class signinWidget extends StatefulWidget {
  const signinWidget({Key? key,
    required this.Title,
    required this.subTitle,
    required this.percent,
    required this.pagenum
  }) : super(key: key);

  final String Title;
  final String subTitle;
  final double percent;
  final String pagenum;

  @override
  _signinWidgetState createState() => _signinWidgetState();
}

class _signinWidgetState extends State<signinWidget> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 118.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 283.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: widget.percent,
                          minHeight: 8.h,
                          valueColor: AlwaysStoppedAnimation(primary[30]),
                          backgroundColor: primary[0]!.withOpacity(0.05),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 10.w,
                    ),

                    Text(
                      widget.pagenum,
                      style: labelMedium.copyWith(color:primary[0]?.withOpacity(0.4)),
                    ),



                  ],
                ),

                SizedBox(
                  height: 76.h,
                ),
                Text(widget.Title,
                      style: titleLarge.copyWith(color:primary[40]),
                  ),

                SizedBox(
                  height: 12.h,
                ),

                Text(widget.subTitle,
                  style: labelMedium.copyWith(color:primary[0]?.withOpacity(0.4)),
                    textAlign: TextAlign.center,
                ),

                SizedBox(
                  height: 52.h,
                ),


                // ElevatedButton(
                //     onPressed: () {
                //     },
                //     child: Text(
                //       "다음",
                //       style: textTheme.titleMedium!.copyWith(
                //         color: Colors.white,
                //       ),
                //     ),
                //     style: ButtonStyle(
                //
                //         fixedSize:
                //         MaterialStateProperty.all(Size(327.w, 40.h)),
                //         backgroundColor: MaterialStateProperty.all(
                //           primary[40],
                //         ),
                //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //             RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(15.0),
                //             )
                //         ),
                //         side: MaterialStateProperty.all(
                //           BorderSide(
                //             width: 0,
                //           ),
                //         )),
                //   ),

              ],

          ),

    );
  }
}

final PageController controller =
PageController(initialPage: 0, viewportFraction: 0.8);


class findIdPwWidget extends StatefulWidget {
  const findIdPwWidget({Key? key,
    required this.Title,
    required this.subTitle,
  }) : super(key: key);

  final String Title;
  final String subTitle;

  @override
  _findIdPwWidgetState createState() => _findIdPwWidgetState();
}

class _findIdPwWidgetState extends State<findIdPwWidget> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 118.h,
          ),

          SizedBox(
            height: 76.h,
          ),
          Text(widget.Title,
            style: titleLarge.copyWith(color:primary[40]),
          ),

          SizedBox(
            height: 12.h,
          ),

          Text(widget.subTitle,
            style: labelMedium.copyWith(color:primary[0]?.withOpacity(0.4)),
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: 52.h,
          ),


          // ElevatedButton(
          //     onPressed: () {
          //     },
          //     child: Text(
          //       "다음",
          //       style: textTheme.titleMedium!.copyWith(
          //         color: Colors.white,
          //       ),
          //     ),
          //     style: ButtonStyle(
          //
          //         fixedSize:
          //         MaterialStateProperty.all(Size(327.w, 40.h)),
          //         backgroundColor: MaterialStateProperty.all(
          //           primary[40],
          //         ),
          //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //             RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15.0),
          //             )
          //         ),
          //         side: MaterialStateProperty.all(
          //           BorderSide(
          //             width: 0,
          //           ),
          //         )),
          //   ),

        ],

      ),

    );
  }
}