import 'package:flutter/material.dart';
import 'package:movas/movas.dart';
import 'package:sms_verification/service/sms_verification/sms_verification/sms_verification_request.dart';
import 'package:sms_verification/service/sms_verification/sms_verification_service.dart';

class SmsVerificationAction {
  final SmsVerificationService _smsVerificationService;

  SmsVerificationAction(this._smsVerificationService);

  factory SmsVerificationAction.of(BuildContext context) => SmsVerificationAction(StaticProvider.of(context));

  Future<void> verifyNumber({String phoneNumber}) {
    final request = SmsVerificationRequest(phoneNumber: phoneNumber);
    return _smsVerificationService.verifyPhoneNumber(request: request);
  }
}