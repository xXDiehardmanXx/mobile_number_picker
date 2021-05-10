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
  void dispose() {
    mobileNumber?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => mobileNumber.mobileNumber());
    mobileNumber.getMobileNumberStream.listen((MobileNumber event) {
      if (event?.states == PhoneNumberStates.PhoneNumberSelected) {
        setState(() {
          mobileNumberObject = event;
        });
      }
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
              'Mobile Number: ${mobileNumberObject?.phoneNumber}\n Country Code: ${mobileNumberObject?.countryCode}'),
        ),
      ),
    );
  }
}
