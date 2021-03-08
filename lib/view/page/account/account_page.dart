import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_verification/action/sms_verification_action.dart';
import 'package:sms_verification/view/page/sms_verification/sms_verification_page.dart';
import 'package:sms_verification/view/page/sms_verification/user_phone_number.dart';
import 'package:sms_verification/view/widget/appbar/generic_appbar.dart';
import 'package:sms_verification/view/widget/button/traetelo_button.dart';
import 'package:sms_verification/view/widget/input/traetelo_form_builder_phone_field.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool verified = false;

  @override
  void initState() {
    super.initState();
  }

  var disableResendEmail = false;

  var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: Colors.black, width: 3));

  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  final double spacing = 20;

  final GlobalKey<CustomFormBuilderPhoneFieldState> _formBuilderPhoneFieldKey =
      GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TraeteloAppBar.largeText2(title: 'Profile'),
      body: Column(
        children: [
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Row(
                            children: [
                              Text(
                                "Número verificado",
                                // style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              SizedBox(
                                width: spacing * .3,
                              ),
                              verified
                                  ? Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                                  : Icon(
                                Icons.clear,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: spacing * .3,
                        ),
                        CustomFormBuilderPhoneField(
                          key: _formBuilderPhoneFieldKey,
                          validateOnChange: true,
                          focusNode: focusNodes[3],
                          // initialValue: accountInfo.response.phone.principal,
                          attribute: "principal",
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          onChanged: (s){
                            print('isvalid ${_formBuilderPhoneFieldKey.currentState.phoneNumberValid}');
                          },
                          onEditingComplete: () {
                            return focusNodes[3].unfocus();
                          },
                          defaultSelectedCountryIsoCode: "VE",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: spacing,
                    ),
                    TextButton(onPressed: () async {
                      if (_formBuilderPhoneFieldKey.currentState.phoneNumberValid){
                        final number = _formBuilderPhoneFieldKey.currentState.fullNumber;
                        await SmsVerificationAction.of(context)
                            .verifyNumber(phoneNumber: number);
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SmsVerificationPage(
                                        phoneNumber:
                                        _formBuilderPhoneFieldKey
                                            .currentState
                                            .userPhoneNumber,
                                        onComplete: (phoneNumber, _) async {
                                          _formBuilderPhoneFieldKey.currentState
                                              .updateNumber(await UserPhoneNumber.fromString(phoneNumber));

                                          setState(() {
                                            verified = true;
                                          });

                                          Navigator.of(context).pop();
                                        })));
                      }
                    }, child: Container(
                      child: Text("Verify"),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}