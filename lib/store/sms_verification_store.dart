import 'package:movas/movas.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/service/sms_verification/sms_verification/sms_verification_response.dart';

class SmsVerificationStore extends Store<SmsVerificationResponse> {
  SmsVerificationStore(
      PublishSubject<SmsVerificationResponse> smsVerificationResponse$) {
    listen(smsVerificationResponse$, (response) {
      o$[SmsVerificationResponse].add(response);
    });
  }
}
