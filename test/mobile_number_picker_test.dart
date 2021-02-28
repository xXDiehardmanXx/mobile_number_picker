import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_number_picker/mobile_number_picker.dart';

void main() {
  const MethodChannel channel = MethodChannel('mobile_number_picker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    MobileNumberPicker mobileNumber = MobileNumberPicker();
    expect(await mobileNumber.mobileNumber(), '42');
  });
}
