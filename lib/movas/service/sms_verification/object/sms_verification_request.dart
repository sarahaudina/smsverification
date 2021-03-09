
import '../../http/base_http_request.dart';

class SmsVerificationRequest extends BaseHttpRequest {
  final String phoneNumber;

  SmsVerificationRequest({this.phoneNumber}) : super(endpoint: "");

  factory SmsVerificationRequest.fromMap(Map<String, dynamic> map) {
    return new SmsVerificationRequest(
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'phoneNumber': this.phoneNumber,
    } as Map<String, dynamic>;
  }

  SmsVerificationRequest copyWith({
    String phoneNumber,
  }) {
    if ((phoneNumber == null || identical(phoneNumber, this.phoneNumber))) {
      return this;
    }

    return new SmsVerificationRequest(
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
