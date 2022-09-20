import 'package:catch0/provider/AuthProvider.dart';
import 'package:catch0/widget/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'screen/login.dart';
//

class CatchApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  CatchApp(this.cameras);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MultiProvider(
          providers: [
            Provider<AuthProvider>(
              create: (_) => AuthProvider(FirebaseAuth.instance),
            ),
            StreamProvider(
              create: (context) => context.read<AuthProvider>().authState,
              initialData: null,
            ),
          ],
          child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Catch',
              theme: ThemeData(
                useMaterial3: true,
                primarySwatch: Colors.blue,
                fontFamily: 'NotoSansKR'
              ),
              home: Authentication(),
              // initialRoute: '/splash',
              routes: {
                //'/home': (context) => home(cameras),
                // '/login': (context) => login(cameras),
                // '/splash': (context) => splash(cameras),
                // '/home2':(context)=>HomePage(cameras),
              }

          ),
        );
      },
    );
  }
}
