# mobile_number_picker

Note: It works for Android only because getting mobile number is not supported in IOS.

Mobile Picker uses [Google Auth Api](https://developers.google.com/android/reference/com/google/android/gms/auth/api/package-summary) to access credentail api and then retrieve the phone number hint picker from there.

## Steps to integrate

- Create object of Mobile Number Picker Class.

```dart
MobileNumberPicker mobileNumber = MobileNumberPicker();

```

- Call **mobileNumber** function to initiate the Auth Api.

```dart
mobileNumber.mobileNumber();
```

- Listen to **getMobileNumberStream** to fetch events.

```dart
mobileNumber.getMobileNumberStream.listen((event) {});
```

## MobileNumber Class

Members of mobilenumber class -

- String completeNumber - Return complete mobile number including the country code , eg: +919999999999.

- String phoneNumber - Return mobile number after reducing the country code , eg: 9999999999.

- String countryCode - Return country code from the selected phone number , eg: +91.

- enum state - Whether the mobile number is selected or not.

## Type of state

- PhoneNumberSelected - when user selects one of the number from the hint picker.

- NoneOfTheAbove - when user selects None Of The Above option or dismisses the picker.

::: warning
PhoneNumber is only available if the enum state = PhoneNumberSelected , so first check the state of the event pushed in stream.
:::

## Screenshot

![Image](https://github.com/Aashishm178/mobile_number_picker/blob/master/image/image.png)
