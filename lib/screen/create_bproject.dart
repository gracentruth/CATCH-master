import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import 'package:catch0/screen/todaycatch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../widget/widget.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'catchbox.dart';
import 'package:intl/intl.dart';

class CreateBproject extends StatefulWidget {
  const CreateBproject({Key? key}) : super(key: key);

  @override
  _CreateBprojectState createState() => _CreateBprojectState();
}

class _CreateBprojectState extends State<CreateBproject> {
  final _titleController = TextEditingController();
  final  _compNameController = TextEditingController();
  final _ceoNameController = TextEditingController();
  final _managerNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _unitPriceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _contextController = TextEditingController();
  String total_cash = "";

  String image_url = "";

  // File? _image;
  String dateTime = "";
  String _selectedObject = "";
  String naming = "";

  //_quantityController.text=null;
  // String _resultText = '';
  // double unitPrice = double.parse(_unitPriceController.value.text);
  // double quantity = double.parse(_quantityController.value.text);
  // double result;
  // result = (unitPrice * quantity);
  // _resultText = result.toString();
  User? user = FirebaseAuth.instance.currentUser;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  var _selectDateIcon = true;

  String _dateCount = '';
  String _selectedDate = '';
  String _rangeCount = '';

  String _range1 = '';
  String _range2 = '';
  DateRangePickerController _dataPickerController = DateRangePickerController();
  String _selectDate = '??????';
  Color _selectDateColor = Color(0XFFF3F4F5);
  Color _selectDateTextColor = Color(0xFF9FA5B2);
  double _selectDateSize = 67.2.w;

  //var _selectDateIcon = true;

  // ??????????????? ?????? ????????????
  //image picker
  void _getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    File selected_image = File(image!.path);

    setState(() {
      dateTime = DateTime.now().toString();
      if (image != null) {
        _image = selected_image;
      }
    });
  }

  create() async {
    dateTime = DateTime.now().toString();
    String newTime = dateTime;
    naming = _titleController.text + dateTime;
    newTime = newTime.replaceAll("-", "");
    newTime = newTime.replaceAll(":", "");
    newTime = newTime.replaceAll(" ", "");
    double dateTimeForOrder = double.parse(newTime);
    print(dateTimeForOrder);
    // _resultLabel.add(_whatController.text);
    //
    // category_changer();
    // valuelist_changer();

    try {
      await FirebaseFirestore.instance.collection('project').doc(naming).set({
        "title": _titleController.text,
        "quantity": _quantityController.text,
        "unitPrice": _unitPriceController.text,
        "content": _contextController.text,
        "cash": calculateIncome(),
        "category": "????????????",
        "final_day": _range2,
        "id": user!.uid,
        "participate": 0,
        "percentage": 0,
        "creation_time": dateTime,
        "place": "????????? ?????? ?????????",
        "url": image_url,
        "comp_name": _compNameController.text,
        "ceo_name":_ceoNameController.text,
        "manager_name": _managerNameController.text,
        "phone_num": _phoneNumberController.text,
        "email": _emailController.text,
        "certification_photo": image_url,
        // "username": user!.displayName,
        // "userprofile": user!.photoURL,
      });
    } catch (e) {
      print(e);
    }
  }

  Image_upload() async {
    if (_image != null) {
      var snapshot = await FirebaseStorage.instance
          .ref()
          .child('$dateTime.png')
          .putFile(_image!); // ?????? ?????????

      String url = await snapshot.ref.getDownloadURL();
      //print(url);
      image_url = url;
      await update(url);
    } else {
      String url =
          await FirebaseStorage.instance.ref('default.png').getDownloadURL();
      await update(url);
    }
  }

  //update url
  update(String url) async {
    try {
      FirebaseFirestore.instance
          .collection("personalProject")
          .doc(naming)
          .update({"url": url});
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _contextController.dispose();
    super.dispose();
  }

  int? _result;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final _formKey = GlobalKey<FormState>();
    // var t1 = int.parse(_quantityController.text);
    // var t2 = int.parse(_unitPriceController.text);

    // ID: x['user'],
    // title: x['title'],
    // cash: x['cash'].toString(),
    // percent: x['percentage'].toString(),
    // daysdue: x['final_day'].toString(),
    // category: x['category'],
    // participate: x['participate'],

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      setState(() {
        if (args.value is PickerDateRange) {
          //List<int> days = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
          //_range1 = '${DateFormat('dd/MM/yyyy').format(args.value.Date)}';
          //_range2 = '${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
          // I tried to use whereIn(), but only 10 elements are available.
          // for(int i = int.parse(_range1.substring(3,5)); i<= int.parse(_range2.substring(3,5)); i++){
          //   if(i == int.parse(_range1.substring(3,5)))
          //     for(int j = int.parse(_range1.substring(0,2)); j < days[i]; j++){
          //       String temp = (j.toString()) + (i.toString()) + _range1.substring(5,8);
          //       num_list.add(temp);
          //     }
          //   if(i == _range2.substring(3,5))
          //     for(int j = 1; j <= int.parse(_range2.substring(0,2)); j++){
          //       String temp = j.toString() + i.toString() + _range1.substring(5,8);
          //       num_list.add(temp);
          //     }
          //   else
          //     for(int j = 1; j <= days[i]; j++){
          //       String temp = j.toString() + i.toString() + _range1.substring(4,8);
          //       num_list.add(temp);
          //     }
          //   print(i);
          // }
          //print(num_list);
          //print(args.value.startDate - args.value.endDate);
        } else if (args.value is DateTime) {
          _selectedDate = args.value.toString();
          _range1 = '${DateFormat('dd/MM/yyyy').format(args.value)}';
        } else if (args.value is List<DateTime>) {
          _dateCount = args.value.length.toString();
        } else {
          _rangeCount = args.value.length.toString();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '?????? ???????????? ?????????',
            style: textTheme.titleMedium!.copyWith(
              color: Colors.black,
            ),
          ),
        ),
        leading: TextButton(
          //icon: new Icon(Icons.accessibility),
          child: Text(
            '??????',
            style: textTheme.titleMedium!.copyWith(
              color: primary[0]?.withOpacity(0.4),
            ),
          ),
          onPressed: () {
            //Navigator.pop(context);
            Get.to(() => todaycatch());
          },
        ),
        actions: [
          TextButton(
            //icon: new Icon(Icons.accessibility),
            child: Text(
              '????????????',
              style: textTheme.titleMedium!.copyWith(
                color: primary[40],
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print("upload ok");
                Get.to(() => todaycatch());
                Image_upload().then(create());
              }
            },
          ),
          //menuButton,
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(19.w, 10.h, 19.w, 0),
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 12.h),
              TextFormField(
                controller: _compNameController,
                autocorrect: true,
                style: textTheme.labelLarge!,
                decoration: InputDecoration(
                  filled: true,
                  hintText: '?????????',
                  hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
                  fillColor: Color.fromRGBO(255, 255, 255, 255),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '???????????? ???????????????';
                  }
                },
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                width: 340.w,
                color: primary[0]!.withOpacity(0.05),
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: _ceoNameController,
                autocorrect: true,
                style: textTheme.labelLarge!,
                decoration: InputDecoration(
                  filled: true,
                  hintText: '????????? ??????',
                  hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
                  fillColor: Color.fromRGBO(255, 255, 255, 255),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '????????? ????????? ???????????????';
                  }
                },
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                width: 340.w,
                color: primary[0]!.withOpacity(0.05),
              ),
              TextFormField(
                controller: _managerNameController,
                autocorrect: true,
                style: textTheme.labelLarge!,
                decoration: InputDecoration(
                  filled: true,
                  hintText: '????????? ??????',
                  hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
                  fillColor: Color.fromRGBO(255, 255, 255, 255),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '????????? ????????? ???????????????';
                  }
                },
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                width: 340.w,
                color: primary[0]!.withOpacity(0.05),
              ),
              Row(
                children: [
                  SizedBox(width: 5.w),
                  Expanded(
                    child:Text(
                      '??????',
                      style: textTheme.titleSmall!
                          .copyWith(color: primary[0]!.withOpacity(0.5)),
                    ),
                  ),
                  // Flexible(child:
                  // Conta),
                  SizedBox(
                    width: 232.w,
                  ),
                  IconButton(
                      onPressed: () {
                        // geolocator
                      },
                      icon: Icon(Icons.keyboard_arrow_right))
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                width: 340.w,
                color: primary[0]!.withOpacity(0.05),
              ),
              TextFormField(
                controller: _phoneNumberController,
                autocorrect: true,
                style: textTheme.labelLarge!,
                decoration: InputDecoration(
                  filled: true,
                  hintText: '?????????',
                  hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
                  fillColor: Color.fromRGBO(255, 255, 255, 255),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '???????????? ???????????????';
                  }
                },
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                width: 340.w,
                color: primary[0]!.withOpacity(0.05),
              ),
              TextFormField(
                controller: _emailController,
                autocorrect: true,
                style: textTheme.labelLarge!,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'E-mail',
                  hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
                  fillColor: Color.fromRGBO(255, 255, 255, 255),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '???????????? ???????????????';
                  }
                },
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                width: 340.w,
                color: primary[0]!.withOpacity(0.05),
              ),
              Row(
                children: [
                  SizedBox(width: 5.w),
                  Text(
                    '????????? ??????????????? ??????',
                    style: textTheme.titleSmall!
                        .copyWith(color: primary[0]!.withOpacity(0.5)),
                  ),
                  Expanded(
                    child: SizedBox(
                    width: 232.w,
                  ),),
                  Expanded(child: IconButton(
                      onPressed: () {
                        // geolocator
                      },
                      icon: Icon(Icons.keyboard_arrow_right))),

                ],
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                width: 340.w,
                color: primary[0]!.withOpacity(0.05),
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: _titleController,
                autocorrect: true,
                style: textTheme.labelLarge!,
                decoration: InputDecoration(
                  filled: true,
                  hintText: '???????????? ??????',
                  hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
                  fillColor: Color.fromRGBO(255, 255, 255, 255),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '???????????? ????????? ???????????????';
                  }
                },
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                width: 340.w,
                color: primary[0]!.withOpacity(0.05),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  SizedBox(width: 5.w),
                  Text(
                    '?????? ??????',
                    style: textTheme.titleSmall!
                        .copyWith(color: primary[0]!.withOpacity(0.5)),
                  ),
                  SizedBox(
                    width: 232.w,
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.keyboard_arrow_right))
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                width: 340.w,
                color: primary[0]!.withOpacity(0.05),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Container(
                    width: 70.w,
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      autocorrect: true,
                      style: textTheme.labelLarge!,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: '?????? 50???',
                        hintStyle:
                            TextStyle(color: primary[0]!.withOpacity(0.2)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
                        fillColor: Color.fromRGBO(255, 255, 255, 255),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 255)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 255)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '????????? ??????????????????';
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 2.w),
                  SizedBox(
                      width: 1.w,
                      child: Icon(Icons.close,
                          color: primary[0]!.withOpacity(0.2))),
                  SizedBox(width: 22.w),
                  Container(
                    width: 70.w,
                    child: TextFormField(
                      controller: _unitPriceController,
                      keyboardType: TextInputType.number,
                      autocorrect: true,
                      style: textTheme.labelLarge!,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: '??? ??? ??????',
                        hintStyle:
                            TextStyle(color: primary[0]!.withOpacity(0.2)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
                        fillColor: Color.fromRGBO(255, 255, 255, 255),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 255)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 255)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '?????? ???????????? ????????? ??????????????????';
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 70.w),
                  Text(
                    '???',
                    style: textTheme.titleSmall!.copyWith(color: Colors.black),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    calculateIncome(),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '??????',
                    style: textTheme.titleSmall!.copyWith(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                width: 340.w,
                color: primary[0]!.withOpacity(0.05),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    '???????????? ??????',
                    style: textTheme.titleSmall!
                        .copyWith(color: primary[0]!.withOpacity(0.5)),
                  ),
                  SizedBox(
                    width: 195.w,
                  ),
                  IconButton(
                      onPressed: () {
                        InkWell(
                          onTap: () {
                            if (_selectDateIcon)
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            topRight: Radius.circular(30.0))),
                                    insetPadding: EdgeInsets.only(top: 229.h),
                                    content: Container(
                                        height: 512.h,
                                        width: 360.w,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  24.w, 30.h, 24.w, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text('??????',
                                                            style: textTheme
                                                                .titleSmall),
                                                        if (_range1 != '')
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  _range1
                                                                      .substring(
                                                                          0, 2),
                                                                  style: textTheme
                                                                      .headlineLarge),
                                                              SizedBox(
                                                                  width: 10.w),
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(_range1.substring(
                                                                            6,
                                                                            10) +
                                                                        '??? ' +
                                                                        _range1.substring(
                                                                            3,
                                                                            5)),
                                                                    Text('?????????')
                                                                  ])
                                                            ],
                                                          )
                                                        else
                                                          Row(
                                                            children: [
                                                              Text(_range1),
                                                              SizedBox(
                                                                  width: 10.w),
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                        _range1),
                                                                    Text('')
                                                                  ])
                                                            ],
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 76.w),
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text('??????',
                                                            style: textTheme
                                                                .titleSmall),
                                                        if (_range2 != '')
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  _range2
                                                                      .substring(
                                                                          0, 2),
                                                                  style: textTheme
                                                                      .headlineLarge),
                                                              SizedBox(
                                                                  width: 10.w),
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(_range2.substring(
                                                                            6,
                                                                            10) +
                                                                        '??? ' +
                                                                        _range2.substring(
                                                                            3,
                                                                            5)),
                                                                    Text('')
                                                                  ])
                                                            ],
                                                          )
                                                        else
                                                          Row(
                                                            children: [
                                                              Text(_range2),
                                                              SizedBox(
                                                                  width: 10.w),
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                        _range2),
                                                                    Text('')
                                                                  ])
                                                            ],
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 60.h),
                                            SfDateRangePicker(
                                              controller: _dataPickerController,
                                              onSelectionChanged:
                                                  _onSelectionChanged,
                                              selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .range,
                                            ),
                                            SizedBox(height: 30.h),
                                            Container(
                                                child: Row(
                                              children: [
                                                SizedBox(width: 208.w),
                                                TextButton(
                                                    child: Text('??????'),
                                                    onPressed: () {
                                                      setState(() {
                                                        _range1 = '';
                                                        _range2 = '';
                                                        _dataPickerController
                                                                .selectedRanges =
                                                            null;
                                                      });
                                                      //Navigator.pop(context);
                                                    },
                                                    style: TextButton.styleFrom(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        minimumSize:
                                                            Size(50, 30),
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        alignment: Alignment
                                                            .centerLeft)),
                                                SizedBox(width: 32.w),
                                                TextButton(
                                                    child: Text('??????'),
                                                    onPressed: () {
                                                      setState(() {
                                                        _selectDateColor =
                                                            primary[40]!;
                                                        _selectDateTextColor =
                                                            Colors.white;
                                                        _selectDate = _range1
                                                                .substring(
                                                                    8, 10) +
                                                            '.' +
                                                            _range1.substring(
                                                                3, 5) +
                                                            '.' +
                                                            _range1.substring(
                                                                0, 2);
                                                        _selectDateSize = 80.w;
                                                        _selectDateIcon = false;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    style: TextButton.styleFrom(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        minimumSize:
                                                            Size(50, 30),
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        alignment: Alignment
                                                            .centerLeft))
                                              ],
                                            ))
                                          ],
                                        )),
                                  );
                                },
                              );
                            else
                              setState(() {
                                _selectDateIcon = true;
                                _selectDate = '??????';
                                _selectDateColor = Color(0XFFF3F4F5);
                                _selectDateTextColor = Color(0xFF9FA5B2);
                                _selectDateSize = 67.2.w;
                                _range1 = '';
                                _range2 = '';
                              });
                          },
                          //1-1
                          child: Container(
                              width: _selectDateSize,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: _selectDateColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _selectDate,
                                    style: TextStyle(
                                      color: _selectDateTextColor,
                                    ),
                                  ),
                                  Icon(
                                      _selectDateIcon
                                          ? Icons.keyboard_arrow_down_outlined
                                          : Icons.clear_outlined,
                                      color: _selectDateTextColor),
                                ],
                              )),
                        );
                      },
                      icon: Icon(Icons.keyboard_arrow_right))
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                width: 340.w,
                color: primary[0]!.withOpacity(0.05),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    '?????? ?????? ??????',
                    style: textTheme.titleSmall!
                        .copyWith(color: primary[0]!.withOpacity(0.5)),
                  ),
                  SizedBox(
                    width: 205.w,
                  ),
                  IconButton(
                      onPressed: () {
                        _getImage();
                        //Get.to(() => Catchbox());
                      },
                      icon: Icon(Icons.keyboard_arrow_right))
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                width: 340.w,
                color: primary[0]!.withOpacity(0.05),
              ),
              SizedBox(height: 5.h),
              TextFormField(
                controller: _contextController,
                autocorrect: true,
                style: textTheme.labelLarge!,
                decoration: InputDecoration(
                  filled: true,
                  hintText: '???????????? ????????? ?????? ????????? ????????? ???????????????.',
                  hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(5.w, 20.h, 0.w, 20.h),
                  fillColor: Color.fromRGBO(255, 255, 255, 255),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '???????????? ????????? ?????? ????????? ??????????????????';
                  }
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  String calculateIncome() {
    int quantity;
    int unitPrice;
    if (_quantityController.text.isEmpty || _unitPriceController.text.isEmpty) {
      //print("Here");
      //return "0";
      quantity = 0;
      unitPrice = 0;
    } else {
      quantity = int.parse(_quantityController.text);
      unitPrice = int.parse(_unitPriceController.text);
    }

    int result = quantity * unitPrice;
    _result = result;
    setState(() {
      _result = result;
    });

    String StringResult = "";
    StringResult = _result.toString();
    return StringResult;
  }
}
