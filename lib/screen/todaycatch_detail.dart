import 'package:catch0/screen/todaycatch_detail2.dart';
import 'package:catch0/screen/todaycatch_detail3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class todaycatchdetail extends StatefulWidget {
  final QueryDocumentSnapshot query;

  todaycatchdetail({required this.query});

  @override
  State<todaycatchdetail> createState() => _todaycatchdetailState(query : query);
}

class _todaycatchdetailState extends State<todaycatchdetail> {
  final QueryDocumentSnapshot query;
  _todaycatchdetailState({required this.query});

  Color _color = Color(0xFFCFD2D9);
  bool _onTap = true;

  bool _onTap2 = true;
  bool _onTap3 = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 캐치'),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(24.w, 40.h, 24.w, 32.h),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    clipper: MyClipper(),
                    child: Image.asset('assets/images/2.jpeg',
                        height: 30.w,
                        fit : BoxFit.fitWidth),
                  ),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Catcher', style: labelLarge),
                    ],
                  ),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.more_vert)
                          ]
                      )
                  )
                ],
              ),
              SizedBox(height: 20.h),
              Text(query['title'], style: titleLarge),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(query['cash'].toString(), style: titleSmall),
                  Text('캐시', style: titleSmall),
                ],
              ),
              SizedBox(height: 20.h),
              Text(query['content'], style: bodyMedium),
              SizedBox(height: 30.h),
              Row(
                children: [
                  for(int i = 0; i<query['category'].length; i++)
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      //height: 25.h,
                      child:  Chip(
                        label: Text(query['category'][i], style: labelMedium),
                        backgroundColor: Color(0xFFF3F4F5),
                        deleteIcon: Icon(
                          Icons.close,
                          size: 8.w,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height:30.h),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: 0.04,
                  minHeight: 8.h,
                  valueColor: AlwaysStoppedAnimation(primary[50]),
                  backgroundColor: Color(0xFFF3F4F5),
                ),
              ),
              SizedBox(height:10.h),
              Row(
                children: [
                  Text(query['percentage'].toString(), style: labelLarge),
                  Text('% 달성', style: labelLarge),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${query['final_day'].toString()}일 후 마감', style: labelSmall)
                      ]
                    ),
                  )
                ],
              ),
            ],
          )
        ]
      ),
        bottomNavigationBar: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.w, 0, 24.w, 62.h),
          child: FloatingActionButton(
            backgroundColor: primary[40],
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
                    insetPadding: EdgeInsets.only(top: 334.h),
                    content: Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 30.h, 0, 0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(18.w, 20.h, 19.w, 20.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFCFD2D9),
                                      spreadRadius: 1,
                                      blurRadius: 50,
                                      //offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                              width: 312.w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    color: _onTap? primary: Color(0xFFCFD2D9),
                                      onPressed: (){
                                        _onTap =!_onTap;
                                        if(_onTap == true && _onTap2 == true)
                                          _onTap3 = true;
                                        if(_onTap2 == true && _onTap == true)
                                          _onTap3 = true;
                                        else
                                          _onTap3 = false;
                                      },
                                      icon: Icon(Icons.check),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('개인정보 및 데이터 수집 및 이용 동의', style: titleMedium),
                                      //SizedBox(height: 16.h),
                                      Row(
                                        children: [
                                          Text('개인정보 통합 관리 및 조회', style: labelLarge),
                                          //SizedBox(width: 81.w),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            color: Color(0xFFCFD2D9),
                                            onPressed: (){

                                            },
                                            icon: Icon(Icons.navigate_next),
                                          ),

                                        ],
                                      ),
                                      //SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          Text('응답내용', style: labelLarge),
                                          //SizedBox(width: 174.w),
                                          IconButton(
                                            color: Color(0xFFCFD2D9),
                                            constraints: BoxConstraints(),
                                            padding: EdgeInsets.zero,
                                            onPressed: (){

                                            },
                                            icon: Icon(Icons.navigate_next),
                                          ),

                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ),
                            SizedBox(height:20.h),
                            Container(
                                padding: EdgeInsets.fromLTRB(18.w, 20.h, 19.w, 20.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFCFD2D9),
                                      spreadRadius: 1,
                                      blurRadius: 50,
                                      //offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: 312.w,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        _onTap2 =!_onTap2;
                                        if(_onTap == true && _onTap2 == true)
                                          _onTap3 = true;
                                        else
                                          _onTap3 = false;
                                      },
                                      color: _onTap2? primary: Color(0xFFCFD2D9),
                                      icon: Icon(Icons.check),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('개인정보 및 데이터 수집 및 이용 동의', style: titleMedium),
                                        //SizedBox(height: 16.h),
                                        Row(
                                          children: [
                                            Text('개인정보 통합 관리 및 조회', style: labelLarge),
                                            //SizedBox(width: 81.w),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints: BoxConstraints(),
                                              color: Color(0xFFCFD2D9),
                                              onPressed: (){

                                              },
                                              icon: Icon(Icons.navigate_next),
                                            ),

                                          ],
                                        ),
                                        //SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            Text('응답내용', style: labelLarge),
                                            //SizedBox(width: 174.w),
                                            IconButton(
                                              color: Color(0xFFCFD2D9),
                                              constraints: BoxConstraints(),
                                              padding: EdgeInsets.zero,
                                              onPressed: (){

                                              },
                                              icon: Icon(Icons.navigate_next),
                                            ),

                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )
                            ),
                            SizedBox(height: 30.h,),
                              FloatingActionButton(
                                backgroundColor: _onTap3? primary[40] : Color(0xFFCFD2D9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(30.0))
                                ),
                                child: Text('모두 동의하고 시작하기', style: titleMedium),
                                onPressed: () {
                                    print("here");
                                    print(query["id"]);
                                    FirebaseFirestore.instance.collection('project').doc(query['id']).update({
                                      'participate' : 1
                                    });
                                  if(_onTap3 == true)
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return todaycatchdetail3(query: query);
                                    }));
                                }
                              )

                          ],
                        ),
                      ),
                    )
                  );
                },
              );
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return todaycatchdetail2();
              // }));
            },
            child: Text('프로젝트 참여하기', style: titleMedium),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))
            ),
          ),
        )
    );
  }
}

class MyClipper extends CustomClipper<Rect>{

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 30.w, 30.w);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
