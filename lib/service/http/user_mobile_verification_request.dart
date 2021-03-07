
import 'base_http_request.dart';

class UserMobileVerificationRequest extends BaseHttpRequest {
  final String action;
  final String customerId;
  final bool verified;

  UserMobileVerificationRequest({
    this.action,
    this.customerId,
    this.verified,
  }) : super(endpoint: "/verifynumber");

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'action': this.action,
      'customerId': this.customerId,
      'verified': this.verified,
    } as Map<String, dynamic>;
  }

// - action: verifyPhone
  // - customerId: 4538792
  // - verified: boolean

}
