import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:sms_verification/movas/view/page/sms_verification/user_phone_number.dart';

class TelephoneNumberWidget extends StatelessWidget {
  final UserPhoneNumber phoneNumber;

  const TelephoneNumberWidget({Key key, this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getFlagUri(phoneNumber) != null
            ? Image.asset(
                _getFlagUri(phoneNumber),
                height: 16.0,
                width: 24.0,
                fit: BoxFit.fill,
                package: "country_pickers",
              )
            : Container(),
        SizedBox(width: 8),
        Flexible(
          child: Text("${phoneNumber.fullPhoneNumber}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.green, fontSize: 16)),
        ),
      ],
    );
  }

  String _getFlagUri(UserPhoneNumber phone) {
    if (phone.countryIsoCode != null) {
      return CountryPickerUtils.getFlagImageAssetPath(phone.countryIsoCode);
    }
  }
}
