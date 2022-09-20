import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widget/buttonWidget.dart';
import 'catchbox_detail.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'catchbox_detail2.dart';

class Catchbox2 extends StatefulWidget {
  final QueryDocumentSnapshot query;

  Catchbox2({required this.query});

  @override
  _Catchbox2State createState() => _Catchbox2State(query : query);
}

class _Catchbox2State extends State<Catchbox2> {
  final storageRef = FirebaseStorage.instance.ref();

  final QueryDocumentSnapshot query;
  _Catchbox2State({required this.query});

  Reference ref = FirebaseStorage.instance
      .ref()
      .child('gallery')
      .child('motorcycle')
      .child('motorcycle1.png');

  Future<void> _downloadLink(Reference ref) async {
    final link = await ref.getDownloadURL();

    await Clipboard.setData(
      ClipboardData(
        text: link,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Success!\n Copied download URL to Clipboard!',
        ),
      ),
    );
  }

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> downloadURL(String imageName) async {
    String url = await storage.ref('$imageName').getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(114.h),
        child: AppBar(
          title: Column(
            children: [
              SizedBox(height: 42.h,),
              Text('캐치박스',
                style: textTheme.titleMedium!.copyWith(color:Colors.black),
              ),
              SizedBox(height: 14.h,),
            ],
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('category').doc(FirebaseAuth.instance.currentUser!.email).collection('category').orderBy('category', descending: true).snapshots(),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return Container(
                          margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 10.h),
                          child: Center(
                              child: GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  childAspectRatio: 19 / 20,
                                  children: List.generate(snapshot.data!.docs.length, (index) {
                                    QueryDocumentSnapshot x = snapshot.data!.docs[index];
                                    return InkWell(
                                      onTap: (){
                                        //_selectedDate = '';
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Catchbox_detail2(query: x, query2: query),));
                                        // 밑에꺼로 정보 넘겨줘야함.
                                        //Catchbox_detail(query: x),));
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 160.65.h,
                                            width: 160.65.w,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(4.76),
                                              ),

                                              clipBehavior: Clip.antiAlias,
                                              child: Image.network(
                                                x['new'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Container(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 5.w),
                                                  Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            x['category'],
                                                            style: Theme.of(context).textTheme.labelMedium,
                                                            maxLines:1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          //const SizedBox(height: 8.0),
                                                          // Text(
                                                          //   "${snapshot.data!.docs[index]['count']}",
                                                          //   //FirebaseFirestore.instance.collection('category').doc('user1').collection(snapshot.data!.docs[index]['category']).doc('date').collection('date').snapshots().length.toString(),
                                                          //   style: Theme.of(context).textTheme.labelSmall,
                                                          // ),
                                                        ],
                                                      )
                                                  )
                                                ],
                                              )
                                          ),
                                          SizedBox(height: 12)
                                        ],
                                      ),


                                      // Padding(
                                      //   padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 5.0),
                                      //   child: Column(
                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                      //     children: <Widget>[
                                      //       Text(
                                      //         x['category'],
                                      //         style: Theme.of(context).textTheme.headline6,
                                      //         maxLines:1,
                                      //         overflow: TextOverflow.ellipsis,
                                      //       ),
                                      //       const SizedBox(height: 8.0),
                                      //       Text(
                                      //         //"${x['price'].toString()}원",
                                      //         '몇개인지',
                                      //         style: Theme.of(context).textTheme.subtitle2,
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),

                                    );
                                  },
                                  )
                              )
                          ),
                        );
                      }
                      else{
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                )
            ),
          ],
        ),
      ),
    );
  }
}