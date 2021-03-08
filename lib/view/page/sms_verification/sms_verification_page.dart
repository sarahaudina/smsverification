import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:sms_verification/helper/logger/logger.dart';
import 'package:sms_verification/service/sms_verification/sms_verification/sms_verification_response.dart';
import 'package:sms_verification/view/page/sms_verification/user_phone_number.dart';
import 'package:sms_verification/view/widget/appbar/generic_appbar.dart';
import 'package:sms_verification/view/widget/button/traetelo_button.dart';
import 'package:sms_verification/view/widget/button/verification_button.dart';
import 'package:sms_verification/view/widget/dialog/phone_confirmation_dialog.dart';
import 'package:sms_verification/view/widget/input/telephone_number_widget.dart';
import 'package:sms_verification/view/widget/input/traetelo_pin_decoration.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class SmsVerificationPage extends StatefulWidget {
  final UserPhoneNumber phoneNumber;
  final bool firstTime;
  final int countDownSecond;
  final Function(String, bool) onComplete;

  const SmsVerificationPage(
      {Key key,
      this.phoneNumber,
      this.firstTime = false,
      this.countDownSecond = 60,
      this.onComplete})
      : super(key: key);

  @override
  _SmsVerificationPageState createState() => _SmsVerificationPageState();
}

class _SmsVerificationPageState extends State<SmsVerificationPage> {
  UserPhoneNumber phoneNumber;
  bool pinIncorrect = false;
  TextEditingController _textInputController = TextEditingController();
  final pinFocusNode = FocusNode();
  final GlobalKey<VerificationResendButtonState> _verificationResendButtonKey =
      GlobalKey();

  @override
  initState() {
    super.initState();
    phoneNumber = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: TraeteloAppBar.largeText2(title: 'Verificar número\nde móvil'),
        body: Consumer<SmsVerificationResponse>(builder: (_, smsResponse, __) {
          logger.info(
              "verify number verif code : ${smsResponse?.verificationCode}");
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 32.0, bottom: 8, right: 32),
                    child: Text(
                        "Ingrese el código de verificación\nque le enviamos a su número de\nteléfono móvil ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17))),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 32, right: 32, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TelephoneNumberWidget(phoneNumber: phoneNumber),
                      SizedBox(
                        width: 16,
                        height: 12,
                      ),
                      Container(
                          height: 45,
                          child: TraeteloButton.grey(
                              text: "Cambie el número",
                              compressed: true,
                              onTap: (() {
                                return showDialog(
                                        context: context,
                                        builder: (context) =>
                                            PhoneConfirmationDialog(
                                                phoneNumber: phoneNumber))
                                    .then((value) {
                                  if (value is UserPhoneNumber)
                                    setState(() {
                                      phoneNumber = value;
                                      _textInputController.clear();
                                      _verificationResendButtonKey.currentState
                                          .resendCode(value.fullPhoneNumber);
                                    });
                                });
                              })))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Divider(),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  margin: EdgeInsets.only(left: 32, right: 32),
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
                        decoration: CustomBoxLooseDecoration(
                            errorText: pinIncorrect
                                ? "\nIntroduzca el número de pin correcto"
                                : null,
                            strokeColorBuilder: PinListenColorBuilder(
                                Colors.green, Colors.grey[400]),
                            bgColorBuilder: null,
                            obscureStyle: ObscureStyle(isTextObscure: false)),
                        controller: _textInputController,
                        enabled: true,
                        keyboardType: TextInputType.phone,
                        onSubmit: (String pin) {},
                        onChanged: (pin) {
                          logger.info('onChanged execute. pin:$pin');
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
                TraeteloButton.gradient(
                  text: 'Verificar',
                  onTap: (() async {
                    FocusScope.of(context).unfocus();
                    if (_textInputController.text ==
                        "${smsResponse.verificationCode}") {
                      logger.info('submitted pin is correct');

                      // Call action to update user flag & Navigate to appropriate screen
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
                VerificationResendButton(
                    countDownSecond: widget.countDownSecond,
                    phoneNumber: phoneNumber.fullPhoneNumber,
                    key: _verificationResendButtonKey),
                widget.firstTime
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 54.0, top: 45),
                        child: GestureDetector(
                          onTap: () {
                            widget.onComplete(
                                phoneNumber.fullPhoneNumber, false);
                          },
                          child: Text("Verificar más tarde",
                              style: TextStyle(fontSize: 19)),
                        ))
                    : Container()
              ],
            ),
          );
        }));
  }
}
