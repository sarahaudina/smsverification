import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/movas/observable/sms_verification_response.dart';
import 'package:sms_verification/movas/service/sms_verification/sms_verification_service.dart';

class TestSmsVerificationService extends SmsVerificationService {
  TestSmsVerificationService(PublishSubject<SmsVerificationResponse> response$)
      : super(response$);

  @override
  Future<void> verifyPhoneNumber({String phoneNumber}) async {
    final smsVerificationResponse =
        SmsVerificationResponse(
          codeLength: 6,
          verificationCode: 123456
        );

    return response$.add(smsVerificationResponse);
  }
}
