import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Transaction extends StatefulWidget{
  final List<CameraDescription> cameras;

  Transaction(this.cameras);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Container(

        )
    );
  }
}