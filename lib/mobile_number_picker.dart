import 'dart:async';
import 'package:flutter/services.dart';

final String defaultNumber = '1234567890';
final String defaultCountryCode = '+91';

class MobileNumberPicker {
  static const MethodChannel _channel = const MethodChannel('mobile_number');

  ///Listen to events using stream
  StreamController<MobileNumber?>? _streamController =
      StreamController<MobileNumber?>.broadcast();

  Stream<MobileNumber?> get getMobileNumberStream => _streamController!.stream;

  ///Dispose the stream
  void dispose() {
    _streamController?.close();
  }

  ///Call this function to initiate method channel
  Future mobileNumber() async {
    try {
      final String? number = await _channel.invokeMethod('getMobileNumber');
      if (number != null) {
        Map<String, dynamic> data =
            _phoneNumberReducer(number) as Map<String, dynamic>;
        _streamController!.sink.add(MobileNumber(
          completeNumber: number,
          phoneNumber: data['number'] ?? defaultNumber,
          countryCode: data['code'] ?? defaultCountryCode,
          states: PhoneNumberStates.PhoneNumberSelected,
        ));
      } else {
        _streamController!.sink.add(MobileNumber(
          phoneNumber: defaultNumber,
          completeNumber: defaultNumber,
          countryCode: defaultCountryCode,
          states: PhoneNumberStates.NoneOfTheAbove,
        ));
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  ///Function to extract country code and number seperately
  Map _phoneNumberReducer(String number) {
    String addRemoved = number.replaceAll('+', '');
    Map<String, dynamic> reducedMap = Map<String, dynamic>();
    for (int i = 3; i >= 1; i--) {
      String numCode = addRemoved.substring(0, i + 1);
      String number = addRemoved.substring(i + 1, addRemoved.length);
      try {
        if (_phoneNumberList[numCode] == number.length) {
          reducedMap = {
            'code': '+$numCode',
            'number': number,
          };
        }
      } catch (e) {
        throw e;
      }
    }
    return reducedMap;
  }

  ///Map of length of phone number length mapped using country code
  final Map<String, dynamic> _phoneNumberList = {
    '91': 10,
    '358': 10,
    '355': 9,
    '93': 9,
    '213': 9,
    '54': 10,
    '297': 7,
    '374': 6,
    '1': 10,
    '376': 10,
    '244': 10,
    '247': 10,
    '61': 9,
    '672': 9,
    '43': 10,
    '994': 9,
    '973': 8,
    '880': 10,
    '375': 9,
    '32': 9,
    '501': 7,
    '229': 9,
    '975': 10,
    '591': 10,
    '599': 10,
    '387': 8,
    '267': 10,
    '55': 11,
    '246': 7,
    '673': 10,
    '359': 9,
    '226': 8,
    '95': 10,
    '257': 10,
    '855': 9,
    '237': 9,
    '238': 10,
    '236': 10,
    '235': 8,
    '56': 9,
    '86': 11,
    '57': 10,
    '269': 10,
    '242': 10,
    '243': 10,
    '682': 5,
    '506': 8,
    '385': 9,
    '53': 10,
    '357': 8,
    '420': 9,
    '45': 8,
    '253': 10,
    '670': 8,
    '593': 9,
    '20': 10,
    '503': 8,
    '44': 10,
    '240': 10,
    '291': 10,
    '372': 10,
    '251': 10,
    '268': 8,
    '500': 5,
    '298': 5,
    '691': 7,
    '679': 10,
    '33': 9,
    '262': 10,
    '508': 10,
    '596': 10,
    '594': 9,
    '689': 6,
    '241': 7,
    '220': 10,
    '995': 9,
    '49': 10,
    '233': 9,
    '350': 10,
    '30': 10,
    '299': 6,
    '590': 9,
    '502': 8,
    '504': 8,
    '852': 8,
    '36': 9,
    '354': 7,
    '62': 10,
    '98': 11,
    '964': 7,
    '353': 9,
    '972': 9,
    '39': 10,
    '81': 10,
    '7': 10,
    '254': 10,
    '686': 8,
    '383': 8,
    '965': 8,
    '371': 8,
    '961': 8,
    '231': 7,
    '218': 10,
    '370': 8,
    '352': 9,
    '853': 8,
    '60': 7,
    '960': 7,
    '223': 8,
    '230': 8,
    '52': 10,
    '373': 8,
    '377': 8,
    '976': 8,
    '382': 8,
    '212': 9,
    '258': 12,
    '977': 10,
    '31': 9,
    '687': 6,
    '64': 9,
    '505': 8,
    '227': 8,
    '234': 8,
    '683': 4,
    '389': 8,
    '47': 8,
    '968': 8,
    '92': 10,
    '680': 7,
    '970': 9,
    '507': 8,
    '595': 9,
    '51': 9,
    '63': 10,
    '48': 9,
    '351': 9,
    '974': 8,
    '40': 10,
    '966': 9,
    '221': 9,
    '381': 9,
    '65': 8,
    '421': 9,
    '252': 8,
    '27': 9,
    '82': 10,
    '34': 9,
    '94': 7,
    '46': 7,
    '41': 9,
    '963': 9,
    '886': 9,
    '66': 9,
    '228': 8,
    '216': 8,
    '90': 11,
    '380': 9,
    '971': 9,
    '58': 7,
    '84': 9,
    '967': 9,
    '263': 9,
  };
}

class MobileNumber {
  final String? phoneNumber;
  final String? completeNumber;
  final String? countryCode;
  final PhoneNumberStates? states;
  MobileNumber(
      {this.phoneNumber, this.countryCode, this.states, this.completeNumber});
}

///Type of states
enum PhoneNumberStates {
  PhoneNumberSelected,
  NoneOfTheAbove,
}
