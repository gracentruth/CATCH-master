import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class imageview extends StatefulWidget {
  const imageview({Key? key}) : super(key: key);

  @override
  State<imageview> createState() => _imageviewState();
}

class _imageviewState extends State<imageview> {

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> downloadURL(String imageName) async{
    String url = await storage.ref('$imageName').getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('imageVie'),),
      body: Container(
        child: FutureBuilder(
            future: downloadURL('hello'),
            //snapshot.data!['name']
            builder: (BuildContext context,
                AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  //width:180,
                  // height: 300,
                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(10.0),
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Container();
            }),
      ),

      );

  }
}
