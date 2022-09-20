import 'package:camera/camera.dart';
import 'package:catch0/screen/todaycatch_detail.dart';
import 'package:catch0/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:catch0/utils/app_colors.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../widget/card.dart';
import '../widget/custom_appbar.dart';
import 'camera.dart';
import 'create_bproject.dart';
import 'create_pproject.dart';
import 'notFound.dart';
import 'tflite.dart';
import 'catchme.dart';
import 'imageview.dart';

String title = '';


class todaycatch extends StatefulWidget {
  const todaycatch({Key? key}) : super(key: key);

  @override
  State<todaycatch> createState() => _todaycatchState();
}

class _todaycatchState extends State<todaycatch> {

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot ds){
      setState(() {
        title = ds['cash'].toString();
      });
      print(ds['cash']);
      print("cash!!!");
    });
  }


  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    TutorialCoachMark tutorialCoachMark;
    List<TargetFocus> targets = [];

    GlobalKey key = GlobalKey();
    GlobalKey _key1 = GlobalKey();
    GlobalKey _key2 = GlobalKey();
    GlobalKey _key3 = GlobalKey();

    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // appBar: AppBar(
      //   title: Image.asset('assets/images/catch_logo.png', width: 86.w, height: 18.h,),
      //   centerTitle: true,
      // ),
      appBar: CustomAppBar(totalcash: title),
      body: Padding(
        padding: EdgeInsets.all(26),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  Text('캐치가 추천해요!',
                      style: textTheme.labelSmall!
                          .copyWith(color: primary[0]!.withOpacity(0.4))),
                ],
              ),
              SizedBox(width: 20.h),
              Expanded(
                child: ListView(children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('project')
                          .orderBy('cash', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.all(2.0),
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  QueryDocumentSnapshot x =
                                      snapshot.data!.docs[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                todaycatchdetail(query: x),
                                          ));
                                    },
                                    child: cardwidget(
                                      ID: x['user'],
                                      title: x['title'],
                                      cash: x['cash'].toString(),
                                      percent: x['percentage'].toString(),
                                      daysdue: x['final_day'].toString(),
                                      category: x['category'],
                                      participate: x['participate'],
                                    ),
                                  );
                                });
                          } else {
                            return Container(
                                child: Center(
                                    child: Text(
                              'Es wurden noch keine Fotos im Chat gepostet.',
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
                              textAlign: TextAlign.center,
                            )));
                          }
                        } else {
                          return CircularProgressIndicator();
                        }
                      })
                ]),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
/*
        key: key,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
*/
        child: Image.asset(
          'assets/icons/pencil_icon.png',
          height: 30.h,
          width: 30.w,
          //fit : BoxFit.fitWidth
        ),
        buttonSize: const Size(60, 60),
        useRotationAnimation: false,
        //animatedIcon: AnimatedIcons.menu_close,
        // icon: Image.asset('assets/images/catch_logo.png',
        //     height: 30.w,
        //     fit : BoxFit.fitWidth),
        activeIcon: Icons.close,
        animatedIconTheme: IconThemeData(
          size: 22.w,
          color: primary[0]?.withOpacity(0.4),
        ),
        // this is ignored if animatedIcon is non null
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.8,
        activeBackgroundColor: Colors.black.withOpacity(0.8),
        //childrenButtonSize: (const Size.round(100)),
        //activeForegroundColor: Colors.white,
        backgroundColor: primary[40],
        foregroundColor: Colors.white,
        elevation: 0.0,
        direction: SpeedDialDirection.up,
        shape: const CircleBorder(),
        children: [
          // SpeedDialChild(
          //   child:
          //   ElevatedButton.icon(
          //
          //       icon: Image.asset('assets/icons/pencil_icon.png',
          //         height: 20.h,
          //         width: 20.w,
          //         //fit : BoxFit.fitWidth
          //       ),
          //     label: Text('Download'),
          //       onPressed: () { },
          //   ),
          //   // IconButton(
          //   //   icon: Image.asset('assets/icons/pencil_icon.png',),
          //   //   iconSize: 50,
          //   //   onPressed: () {},
          //   // )
          // ),
          SpeedDialChild(
/*
            key: _key1,
            child: Icon(Icons.build),
*/
            child: Image.asset(
              'assets/icons/Subtract.png',
              height: 20.h,
              width: 16.w,
              //fit : BoxFit.fitWidth
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50), //모서리
              //side: BorderSide(color: Colors.black),
            ),
            elevation: 0,
            backgroundColor: primary[50],
            label: '기업, 공공기관 프로젝트 의뢰하기',
            // labelWidget,
            //labelShadow : Colors.black.withOpacity(0.6),
            labelStyle: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              height: 22 / 16,
              letterSpacing: 0,
              //fontWeight: FontWeight.w500,
              color: Colors.white,
              //color: primary[0]?.withOpacity(0.02),
            ),
            labelBackgroundColor: Colors.black.withOpacity(0.6),
              onTap: () {
                // Get.to(() => CreateBproject());
                Get.to(() => notFound());
              }),
          SpeedDialChild(
              child: Image.asset(
                'assets/icons/Union.png',
                height: 24.h,
                width: 21.61.w,
                //fit : BoxFit.fitWidth
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), //모서리
                //side: BorderSide(color: Colors.black),
              ),
              backgroundColor: primary[50],
              label: '개인 프로젝트 올리기',
              labelStyle: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                height: 22 / 16,
                letterSpacing: 0,
                //fontWeight: FontWeight.w500,
                color: Colors.white,
                //color: primary[0]?.withOpacity(0.02),
              ),
              //color: primary[0]?.withOpacity(0.02)),
              labelBackgroundColor: Colors.black.withOpacity(0.6),
              onTap: () {
                Get.to(() => CreatePproject());
              }),
        ],
      ),
    );
  }
}
