import 'package:catch0/screen/todaycatch_detail.dart';
import 'package:catch0/screen/todaycatch_detail3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:camera/camera.dart';
import 'package:catch0/screen/tflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widget/card.dart';


List catchme_list = [true, true, false, false, false, false];

class catchme extends StatefulWidget {
  const catchme({Key? key}) : super(key: key);
  @override
  State<catchme> createState() => _catchmeState();
}

class _catchmeState extends State<catchme> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              color: onErrorColor,
                width:375.w ,
              height: 40.h,
              child:Text('')
            ),
            Container(
              width:375.w ,
              color: onErrorColor,
              height: 40.h,
              child:Center(
                child:Text('마이캐치',
                    style:titleMedium
                )
              )
            ),
            SizedBox(
              height: 180.h,
              width: 375.w,
              child: Card(

                  margin: EdgeInsets.all(0),
                  surfaceTintColor: onErrorColor,
                  shape: RoundedRectangleBorder(
                    //모서리를 둥글게 하기 위해 사용
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  //elevation: kElevationToShadow,
                  //그림자 깊이
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width:10.w
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 86.w,
                                      child: Text('사람', style: titleSmall),
                                    ),
                                    Transform.scale(
                                      scale: 0.8.h,
                                      child: CupertinoSwitch(
                                        activeColor: Colors.blue,
                                        value: catchme_list[0],
                                        onChanged: (value) {
                                          setState(() {
                                            catchme_list[0] = value;
                                            // _switchValue = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 86.w,
                                      child: Text('신호등', style: titleSmall),
                                    ),
                                    Transform.scale(
                                      scale: 0.8.h,
                                      child: CupertinoSwitch(
                                        activeColor: Colors.blue,
                                        value: catchme_list[1],
                                        onChanged: (value) {
                                          setState(() {
                                            catchme_list[1]  = value;
                                            // _switchValue = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 86.w,
                                      child: Text('버스 ', style: titleSmall),
                                    ),
                                    Transform.scale(
                                      scale: 0.8.h,
                                      child: CupertinoSwitch(
                                        activeColor: Colors.blue,
                                        value: catchme_list[2],
                                        onChanged: (value) {
                                          setState(() {
                                            catchme_list[2] = value;
                                            // _switchValue = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width:53.w
                            ),
                            Column(

                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 86.w,
                                      child: Text('오토바이', style: titleSmall),
                                    ),
                                    Transform.scale(
                                      scale: 0.8.h,
                                      child: CupertinoSwitch(
                                        activeColor: Colors.blue,
                                        value: catchme_list[3],
                                        onChanged: (value) {
                                          setState(() {
                                            catchme_list[3] = value;
                                            // _switchValue = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 86.w,
                                      child: Text('정지 표지판', style: titleSmall),
                                    ),
                                    Transform.scale(
                                      scale: 0.8.h,
                                      child: CupertinoSwitch(
                                        activeColor: Colors.blue,
                                        value: catchme_list[4],
                                        onChanged: (value) {
                                          setState(() {
                                            catchme_list[4] = value;
                                            // _switchValue = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 86.w,
                                      child: Text('자전거', style: titleSmall),
                                    ),
                                    Transform.scale(
                                      scale: 0.8.h,
                                      child: CupertinoSwitch(
                                        activeColor: Colors.blue,
                                        value: catchme_list[5],
                                        onChanged: (value) {
                                          setState(() {
                                            catchme_list[5] = value;
                                            // _switchValue = value;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(14.h),
              child:  Center(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('project').where('participate', isEqualTo: 1).orderBy('cash', descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.all(2.0),
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  QueryDocumentSnapshot x = snapshot.data!.docs[index];
                                  return InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) => todaycatchdetail3(query: x),));
                                    },
                                    child: cardwidget(
                                      ID:x['user'],
                                      title:x['title'],
                                      cash: x['cash'].toString(),
                                      percent: x['percentage'].toString(),
                                      daysdue: x['final_day'].toString(),
                                      category: x['category'],
                                      participate: x['participate'],
                                    ),
                                  );
                                }
                            );
                          }else {
                            return Container(
                                child: Center(
                                    child: Text(
                                      'Es wurden noch keine Fotos im Chat gepostet.',
                                      style: TextStyle(fontSize: 20.0, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    )));
                          }
                        } else {return CircularProgressIndicator();}
                      }))
            )
      ],
    )
    );
  }
}
