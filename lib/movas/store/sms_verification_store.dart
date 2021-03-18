import 'package:movas/movas.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/movas/observable/sms_verification_response.dart';

class SmsVerificationStore extends Store<SmsVerificationO> {
  SmsVerificationStore(
      PublishSubject<SmsVerificationResponse> smsVerificationResponse$) {
    listen(smsVerificationResponse$, (response) {
      add(SmsVerificationO(response: response));
    });
  }
}

class SmsVerificationO {
  SmsVerificationResponse response;

  SmsVerificationO({
    this.response,
  });

  SmsVerificationO copyWith({
    SmsVerificationResponse response,
  }) {
    return new SmsVerificationO(
      response: response ?? this.response,
    );
  }

  @override
  String toString() {
    return 'SmsVerificationO{response: $response}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is SmsVerificationO &&
              runtimeType == other.runtimeType &&
              response == other.response);

  @override
  int get hashCode => response.hashCode;

  factory SmsVerificationO.fromMap(Map<String, dynamic> map) {
    return new SmsVerificationO(
      response: map['response'] as SmsVerificationResponse,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'response': this.response.toJson(),
    } as Map<String, dynamic>;
  }

  Map<String, dynamic> responseMap() {
    return this.response.toJson();
  }
}
