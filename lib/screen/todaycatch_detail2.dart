import 'package:catch0/screen/todaycatch_detail3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class todaycatchdetail2 extends StatefulWidget {
  const todaycatchdetail2({Key? key}) : super(key: key);

  @override
  State<todaycatchdetail2> createState() => _todaycatchdetail2State();
}

class _todaycatchdetail2State extends State<todaycatchdetail2> {
  bool _isChecked = false;
  bool _isChecked2 = false;
  bool _two_isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('오늘의 캐치'),
        ),
        body: ListView(
            padding: EdgeInsets.fromLTRB(24.w, 25.h, 24.w, 0),
            children: [
              Text('약관', style: titleMedium),
              SizedBox(height: 10.h),
              Text('둘 멀리 잠, 패, 별 파란 라이너 거외다. 어머니, 말 차 봄이 된 피어나듯이 별 못 있습니다. 이름과, 경, 강아지, 거외다. 아침이 이름자 소학교 듯합니다. 둘 속의 그리워 봅니다. 다하지 내일 아침이 별 있습니다. 하나에 지나가는 이국 멀리 마디씩 아스라히 멀리 불러 우는 거외다. 이름을 이름과, 어머니, 피어나듯이 노새, 이름과, 이런 거외다. 다 별이 자랑처럼 슬퍼하는 딴은 불러 별 버리었습니다.'),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value){
                      setState(() {
                         _isChecked = value!;
                         if(_isChecked == true && _isChecked2 == true)
                           _two_isChecked = true;
                      });
                    }
                  ),
                  //SizedBox(width: 10.w),
                  Text('동의하기', style: bodyMedium)
                ],
              ),
              SizedBox(height: 50.h),
              Text(
                  '개인정보 처리',

                  style: TextStyle(
                      color: primary[40],
                  )
              ),
              SizedBox(height: 10.h),
              Text('둘 멀리 잠, 패, 별 파란 라이너 거외다. 어머니, 말 차 봄이 된 피어나듯이 별 못 있습니다. 이름과, 경, 강아지, 거외다. 아침이 이름자 소학교 듯합니다. 둘 속의 그리워 봅니다. 다하지 내일 아침이 별 있습니다. 둘 멀리 잠, 패, 별 파란 라이너 거외다. 어머니, 말 차 봄이 된 피어나듯이 별 못 있습니다. 이름과, 경, 강아지, 거외다. 아침이 이름자 소학교 듯합니다. 둘 속의 그리워 봅니다. 다하지 내일 아침이 별 있습니다. 둘 멀리 잠, 패, 별 파란 라이너 거외다. 어머니, 말 차 봄이 된 피어나듯이 별 못 있습니다. 이름과, 경, 강아지, 거외다. 아침이 이름자 소학교 듯합니다. 둘 속의 그리워 봅니다. 다하지 내일 아침이 별 있습니다. 둘 멀리 잠, 패, 별 파란 라이너 거외다. 어머니, 말 차 봄이 된 피어나듯이 별 못 있습니다. 이름과, 경, 강아지, 거외다. 아침이 이름자 소학교 듯합니다. 둘 속의 그리워 봅니다. 다하지 내일 아침이 별 있습니다. 하나에 지나가는 이국 멀리 마디씩 아스라히 멀리 불러 우는 거외다. 이름을 이름과, 어머니, 피어나듯이 노새, 이름과, 이런 거외다. 다 별이 자랑처럼 슬퍼하는 딴은 불러 별 버리었습니다. 북간도에 너무나 별빛이 시인의 어머니 계집애들의 위에 버리었습니다. 다 경, 언덕 내 거외다. 못 별이 어머니, 하나에 있습니다. 별 위에도 위에 우는 봅니다. 말 벌써 못 내 봅니다. 둘 나는 이름과, 우는 멀리 지나고 오면 버리었습니다. 말 봄이 계집애들의 내린 어머니 거외다. 별 묻힌 벌레는 있습니다. 내린 내일 새겨지는 별 풀이 까닭입니다. 별 가을로 내린 봅니다. 별 걱정도 패, 시인의 봅니다. 지나고 이네들은 하나에 언덕 오면 밤이 청춘이 없이 봅니다. 아침이 별이 우는 오는 말 없이 멀듯이, 봅니다. 겨울이 멀리 내 북간도에 계십니다. 가을로 북간도에 별에도 아스라히 별 내일 까닭입니다. 북간도에 이 벌써 파란 남은 밤을 어머니, 하나에 까닭입니다. 나는 릴케 나의 계십니다. 어머니, 내 않은 별들을 이름을 나는 거외다. 청춘이 이런 하나에 지나가는 어머님, 있습니다. 동경과 별 아름다운 프랑시스 지나고 하나에 헤는 까닭입니다. 아이들의 말 딴은 슬퍼하는 이국 나는 겨울이 나는 아스라히 버리었습니다. 그리워 사람들의 이런 계십니다.둘 멀리 잠, 패, 별 파란 라이너 거외다. 어머니, 말 차 봄이 된 피어나듯이 별 못 있습니다. 이름과, 경, 강아지, 거외다. 아침이 이름자 소학교 듯합니다. 둘 속의 그리워 봅니다. 다하지 내일 아침이 별 있습니다. 하나에 지나가는 이국 멀리 마디씩 아스라히 멀리 불러 우는 거외다. 이름을 이름과, 어머니, 피어나듯이 노새, 이름과, 이런 거외다'),
              Row(
                children: [
                  Checkbox(
                      value: _isChecked2,
                      //fillColor: _isChecked2 ? primary[40] : Colors.white,
                      onChanged: (value){
                        setState(() {
                          _isChecked2 = value!;
                          if(_isChecked == true && _isChecked2 == true)
                            _two_isChecked = true;
                        });
                      }
                  ),
                  //SizedBox(width: 10.w),
                  Text('동의하기', style: bodyMedium),
                  SizedBox(height: 50.h)
                ],
              ),
            ]
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.w, 0, 24.w, 25.h),
          child: FloatingActionButton(
            backgroundColor: _isChecked2? primary[40] : onSecondaryColor,
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   //return todaycatchdetail3();
              // }));
            },
            child: Text('모두 동의하고 시작하기', style: titleMedium),
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