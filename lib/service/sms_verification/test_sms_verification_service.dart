import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/helper/logger/logger.dart';
import 'package:sms_verification/service/sms_verification/sms_verification/sms_verification_request.dart';
import 'package:sms_verification/service/sms_verification/sms_verification/sms_verification_response.dart';
import 'package:sms_verification/service/sms_verification/sms_verification_service.dart';

class TestSmsVerificationService extends SmsVerificationService {
  TestSmsVerificationService(PublishSubject<SmsVerificationResponse> response$)
      : super(response$);

  @override
  Future<void> verifyPhoneNumber({SmsVerificationRequest request}) async {
    final smsVerificationResponse =
        SmsVerificationResponse(
          codeLength: 6,
          verificationCode: 123456
        );

    logger.info("verification code is ${smsVerificationResponse.verificationCode}");
    return response$.add(smsVerificationResponse);
  }
}
