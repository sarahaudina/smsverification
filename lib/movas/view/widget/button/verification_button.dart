import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sms_verification/movas/action/sms_verification_action.dart';
import 'package:sms_verification/movas/view/widget/loading/loading_dialog.dart';

class VerificationResendButton extends StatefulWidget {
  final int countDownSecond;
  final String phoneNumber;

  const VerificationResendButton({Key key, this.countDownSecond, this.phoneNumber})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VerificationResendButtonState();
  }
}

class VerificationResendButtonState extends State<VerificationResendButton> {
  Timer timer;
  int secondsRemaining;
  bool enableResend = false;

  @override
  initState() {
    super.initState();
    secondsRemaining = widget.countDownSecond;
    _startTimer();
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
          timer.cancel();
        });
      }
    });
  }

  resendCode(String number) {
    setState(() {
      secondsRemaining = widget.countDownSecond;
      enableResend = false;
      timer.cancel();
    });

    showLoadingDialog(context);

    SmsVerificationAction.of(context).verifyNumber(phoneNumber: number)
        .then((value) {
      print("request code for ${number}");
      Navigator.pop(context);
      _startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return enableResend
        ? InkWell(
        onTap: (() {
          resendCode(widget.phoneNumber);
        }),
        child: Text("Reenviar Código",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 19, color: Colors.green)))
        : Text("Reenviar código en: ${formatMMSS(secondsRemaining)}",
        textAlign: TextAlign.center, style: TextStyle(fontSize: 16));
  }
}

String formatMMSS(int seconds) {
  seconds = (seconds % 3600).truncate();
  int minutes = (seconds / 60).truncate();

  String minutesStr = (minutes).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  return "$minutesStr:$secondsStr";
}