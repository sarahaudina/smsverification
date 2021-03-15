import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:sms_verification/movas/observable/sms_verification_response.dart';
import 'package:sms_verification/movas/view/page/sms_verification/user_phone_number.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class SmsVerificationPage extends StatefulWidget {
  final UserPhoneNumber phoneNumber;
  final Function(String, bool) onComplete;

  const SmsVerificationPage(
      {Key key,
      this.phoneNumber,
      this.onComplete})
      : super(key: key);

  @override
  _SmsVerificationPageState createState() => _SmsVerificationPageState();
}

class _SmsVerificationPageState extends State<SmsVerificationPage> {
  TextEditingController _textInputController = TextEditingController();
  final pinFocusNode = FocusNode();
  UserPhoneNumber phoneNumber;
  bool pinIncorrect = false;

  @override
  initState() {
    super.initState();
    phoneNumber = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Phone Verification")),
        body: Consumer<SmsVerificationResponse>(builder: (_, smsResponse, __) {
          print("verify number verif code : ${smsResponse?.verificationCode}");
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8, right: 16),
                    child: Text("Enter ${smsResponse.codeLength} digit verification code sent to your phone")),
                SizedBox(
                  height: 16,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: KeyboardActions(
                      disableScroll: true,
                      config: KeyboardActionsConfig(
                        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                        keyboardBarColor: Colors.grey[200],
                        nextFocus: true,
                        actions: [pinFocusNode]
                            .map(
                              (e) => KeyboardActionsItem(
                            focusNode: e,
                            toolbarButtons: [
                              //button 2
                                  (node) {
                                return GestureDetector(
                                  onTap: () => node.unfocus(),
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      "DONE",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }
                            ],
                          ),
                        ).toList(),
                      ),
                      child: PinInputTextField(
                        pinLength: smsResponse?.codeLength ?? 4,
                        focusNode: pinFocusNode,
                        decoration: BoxLooseDecoration(
                          strokeColorBuilder: FixedColorBuilder(Colors.black)
                        ),
                        controller: _textInputController,
                        enabled: true,
                        keyboardType: TextInputType.phone,
                        onSubmit: (String pin) {},
                        onChanged: (pin) {
                          print('onChanged execute. pin:$pin');
                          if (pinIncorrect) {
                            setState(() {
                              pinIncorrect = false;
                            });
                          }
                        },
                        enableInteractiveSelection: false,
                      )),
                ),
                SizedBox(
                  height: 45,
                ),
                TextButton(
                  child: Text('Verify'),
                  onPressed: (() async {
                    FocusScope.of(context).unfocus();
                    if (_textInputController.text == "${smsResponse.verificationCode}") {
                      print('submitted pin is correct');
                      widget.onComplete(phoneNumber.fullPhoneNumber, true);
                    } else {
                      setState(() {
                        pinIncorrect = true;
                      });
                    }
                  }),
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          );
        }));
  }
}
