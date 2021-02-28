import 'dart:async';
import 'package:flutter/services.dart';

class MobileNumberPicker {
  static const MethodChannel _channel = const MethodChannel('mobile_number');
  static StreamController<MobileNumber> _streamController =
      StreamController<MobileNumber>.broadcast();

  Stream get getMobileNumberStream => _streamController.stream;

  static void dispose() {
    _streamController.close();
  }

  Future mobileNumber() async {
    final String number = await _channel.invokeMethod('getMobileNumber');
    if (number != null) {
      _streamController.sink.add(MobileNumber(
        phoneNumber: number,
        states: PhoneNumberStates.PhoneNumberSelected,
      ));
    } else {
      _streamController.sink.add(MobileNumber(
        phoneNumber: null,
        states: PhoneNumberStates.NoneOfTheAbove,
      ));
    }
  }
}

class MobileNumber {
  final String phoneNumber;
  final PhoneNumberStates states;
  MobileNumber({this.phoneNumber, this.states});
}

enum PhoneNumberStates {
  PhoneNumberSelected,
  NoneOfTheAbove,
}
