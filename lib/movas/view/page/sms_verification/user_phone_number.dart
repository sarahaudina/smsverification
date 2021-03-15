import 'package:flutter/foundation.dart';
import 'package:phone_number/phone_number.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/services.dart';

class UserPhoneNumber {
  String normalizedPhoneNumber;
  String countryAreaCode;
  String countryIsoCode;
  String fullPhoneNumber;

  UserPhoneNumber({@required this.fullPhoneNumber, @required this.normalizedPhoneNumber, @required this.countryAreaCode, @required this.countryIsoCode});

  static Future<UserPhoneNumber> fromString(String fullPhoneNumber) async {
    if (!fullPhoneNumber.contains("+")){
      fullPhoneNumber = "+"+fullPhoneNumber;
    }
    var value = await PhoneNumber().parse(fullPhoneNumber);
    return UserPhoneNumber(
        fullPhoneNumber: fullPhoneNumber,
        normalizedPhoneNumber: value['national_number'],
        countryAreaCode: value['country_code'],
        countryIsoCode: CountryPickerUtils.getCountryByPhoneCode(value["country_code"]).isoCode);
  }
}

Future<bool> validatePhoneNumber(String phoneNumber) async {
  try {
    await PhoneNumber().parse(phoneNumber);
  } on PlatformException catch (err) {
    if (err.code=='InvalidNumber'){
      print('InvalidNumber');
      return false;
    }
  } return true;
}