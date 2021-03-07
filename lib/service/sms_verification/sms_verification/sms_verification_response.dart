/// codeLength : 6
/// verificationCode : 804504

class SmsVerificationResponse {
  int _codeLength;
  int _verificationCode;

  int get codeLength => _codeLength;
  int get verificationCode => _verificationCode;

  SmsVerificationResponse({int codeLength, int verificationCode}) {
    _codeLength = codeLength;
    _verificationCode = verificationCode;
  }

  SmsVerificationResponse.fromJson(dynamic json) {
    _codeLength = int.parse(json["codeLength"].toString());
    _verificationCode = int.parse(json["verificationCode"].toString());
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["codeLength"] = _codeLength;
    map["verificationCode"] = _verificationCode;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmsVerificationResponse &&
          runtimeType == other.runtimeType &&
          _codeLength == other._codeLength &&
          _verificationCode == other._verificationCode;

  @override
  int get hashCode => _codeLength.hashCode ^ _verificationCode.hashCode;
}
