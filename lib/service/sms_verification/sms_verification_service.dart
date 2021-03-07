import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/service/sms_verification/sms_verification/sms_verification_request.dart';
import 'package:sms_verification/service/sms_verification/sms_verification/sms_verification_response.dart';

abstract class SmsVerificationService {
  final PublishSubject<SmsVerificationResponse> response$;
  Future<void> verifyPhoneNumber({SmsVerificationRequest request});

  SmsVerificationService(this.response$);

  void dispose() {
    response$.close();
  }
}
