# mobile_number_picker

Note: It works for Android only because getting mobile number is not supported in IOS.
Mobile Number Reducer is added to seperate the mobile number and country code , so you can get both of them seperately.

Usage

Call this Function to initiate the mobile picker dialog

```dart
mobileNumber.mobileNumber();
```

Listen to stream to listen to events added to stream

```dart
mobileNumber.getMobileNumberStream.listen((event) {});
```

##Result
![Image](https://github.com/Aashishm178/mobile_number_picker/blob/master/image/image.png)
