import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movas/movas.dart';
import 'package:sms_verification/movas/action/sms_verification_action.dart';
import 'package:sms_verification/movas/service/sms_verification/sms_verification_service.dart';
import 'package:sms_verification/movas/view/page/sms_verification/sms_verification_page.dart';
import 'package:sms_verification/movas/view/page/sms_verification/user_phone_number.dart';
import 'package:sms_verification/movas/view/widget/input/form_builder_phone_field.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool verified = false;
  String verifiedNumber;

  @override
  void initState() {
    super.initState();
  }

  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  final double spacing = 20;

  final GlobalKey<CustomFormBuilderPhoneFieldState> _formBuilderPhoneFieldKey =   GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Verification")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Enter a phone number to get a text message with a verification code"),
            Container(
              height: 16,
            ),
            CustomFormBuilderPhoneField(
              key: _formBuilderPhoneFieldKey,
              validateOnChange: true,
              focusNode: focusNodes[3],
              attribute: "principal",
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              onEditingComplete: () =>focusNodes[3].unfocus(),
              defaultSelectedCountryIsoCode: "VE",
            ),
            SizedBox(
              height: spacing,
            ),
            _formBuilderPhoneFieldKey.currentState.fullNumber==verifiedNumber && verified ?
                Text("Verified!") :
            TextButton(onPressed: () async {
              if (_formBuilderPhoneFieldKey.currentState.phoneNumberValid){
                final number = _formBuilderPhoneFieldKey.currentState.fullNumber;
                await SmsVerificationAction.of(context).verifyNumber(phoneNumber: number);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) =>
                      SmsVerificationPage(
                          phoneNumber: _formBuilderPhoneFieldKey.currentState.userPhoneNumber,
                          onComplete: (phoneNumber, _) async {
                            _formBuilderPhoneFieldKey.currentState.updateNumber(await UserPhoneNumber.fromString(phoneNumber));
                            setState(() {
                              verified = true;
                              verifiedNumber = phoneNumber;
                            });
                            Navigator.of(context).pop();
                          })));}
            }, child: Container(
              child: Text("Verify"),
            )),
          ],
        ),
      ),
    );
  }
}