import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/service/sms_verification/sms_verification/sms_verification_request.dart';
import 'package:sms_verification/service/sms_verification/sms_verification/sms_verification_response.dart';
import 'package:sms_verification/service/sms_verification/sms_verification_service.dart';

class TestSmsVerificationService extends SmsVerificationService {
  Dio dio = Dio();

  TestSmsVerificationService(PublishSubject<SmsVerificationResponse> response$)
      : super(response$) {
    dio.options.baseUrl =
        "https://wynbwky2bd.execute-api.us-east-2.amazonaws.com/production/testverification";
    dio.options.connectTimeout = 200000; //5s
    dio.options.receiveTimeout = 50000;
  }

  @override
  Future<void> verifyPhoneNumber({SmsVerificationRequest request}) async {
    final response = await dio.get(request.endpoint,
        queryParameters: request.toMap(),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ));

    final json = jsonEncode(response.data);
    final smsVerificationResponse =
        SmsVerificationResponse.fromJson(jsonDecode(json));

    print(response.data);
    return response$.add(smsVerificationResponse);
  }
}
