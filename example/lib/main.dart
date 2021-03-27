import 'package:flutter/material.dart';
import 'package:mobile_number_picker/mobile_number_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MobileNumberPicker mobileNumber = MobileNumberPicker();
  MobileNumber mobileNumberObject = MobileNumber();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => mobileNumber.mobileNumber());
    mobileNumber.getMobileNumberStream.listen((event) {
      setState(() {
        mobileNumberObject = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Number Plugin'),
        ),
        body: Center(
          child: Text(
              'Country Code: ${mobileNumberObject?.countryCode} Mobile Number: ${mobileNumberObject?.phoneNumber}\n'),
        ),
      ),
    );
  }
}
