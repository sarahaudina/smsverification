import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/movas/service/sms_verification/object/sms_verification_request.dart';
import 'package:sms_verification/movas/observable/smsverification/sms_verification_response.dart';

abstract class SmsVerificationService {
  final PublishSubject<SmsVerificationResponse> response$;
  Future<void> verifyPhoneNumber({SmsVerificationRequest request});

  SmsVerificationService(this.response$);

  void dispose() {
    response$.close();
  }
}
