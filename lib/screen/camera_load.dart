import 'package:catch0/screen/tflite.dart';
import 'package:flutter/material.dart';
import 'package:catch0/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../utils/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CamerLoad extends StatefulWidget {
  const CamerLoad({Key? key}) : super(key: key);

  @override
  State<CamerLoad> createState() => _CamerLoadState();
}

class _CamerLoadState extends State<CamerLoad> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return TakePictureScreen2();
    // }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 130.h,),

            SizedBox(height: 60.h,),
            Text("카메라 화면안의 물체를 포함한 박스를 \n 클릭하면  사진이 저장됩니다. ",
              style: titleSmall.copyWith(color:Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h,),
            ElevatedButton(
              onPressed: () async {
                //Get.back();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TakePictureScreen2();
                }));
              },
              child: Text(
                "카메라 사용하기",
              style: titleSmall.copyWith(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(

                  fixedSize: MaterialStateProperty.all(Size(180.w, 40.h)),
                  backgroundColor: MaterialStateProperty.all(
                    primary[40],
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
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



