import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/movas/observable/sms_verification_response.dart';

abstract class SmsVerificationService {
  final PublishSubject<SmsVerificationResponse> response$;
  Future<void> verifyPhoneNumber({String phoneNumber});

  SmsVerificationService(this.response$);

  void dispose() {
    response$.close();
  }
}
