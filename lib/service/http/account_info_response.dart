class AccountInfoResponse {
  final String customer_id;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final Phone phone;
  final String document_id;
  final bool pushNotification;
  final bool verifiedNumber;
  final bool isVerifiedEmail;

  factory AccountInfoResponse.fromData(data) =>
      AccountInfoResponse.fromMap(data['data']);

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const AccountInfoResponse({
    this.customer_id,
    this.first_name,
    this.last_name,
    this.email,
    this.gender,
    this.phone,
    this.document_id,
    this.pushNotification,
    this.verifiedNumber,
    this.isVerifiedEmail,
  });

  AccountInfoResponse copyWith({
    String customer_id,
    String first_name,
    String last_name,
    String email,
    String gender,
    Phone phone,
    String document_id,
    bool pushNotification,
    bool verifiedNumber,
    bool isVerifiedEmail,
  }) {
    if ((customer_id == null || identical(customer_id, this.customer_id)) &&
        (first_name == null || identical(first_name, this.first_name)) &&
        (last_name == null || identical(last_name, this.last_name)) &&
        (email == null || identical(email, this.email)) &&
        (gender == null || identical(gender, this.gender)) &&
        (phone == null || identical(phone, this.phone)) &&
        (document_id == null || identical(document_id, this.document_id)) &&
        (pushNotification == null ||
            identical(pushNotification, this.pushNotification)) &&
        (isVerifiedEmail == null ||
            identical(isVerifiedEmail, this.isVerifiedEmail)) &&
        (verifiedNumber == null ||
            identical(verifiedNumber, this.verifiedNumber))) {
      return this;
    }

    return new AccountInfoResponse(
      customer_id: customer_id ?? this.customer_id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      isVerifiedEmail: isVerifiedEmail ?? this.isVerifiedEmail,
      document_id: document_id ?? this.document_id,
      pushNotification: pushNotification ?? this.pushNotification,
      verifiedNumber: verifiedNumber ?? this.verifiedNumber,
    );
  }

  @override
  String toString() {
    return 'Rootobject{customer_id: $customer_id, first_name: $first_name, last_name: $last_name, email: $email, gender: $gender, phone: $phone, document_id: $document_id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountInfoResponse &&
          runtimeType == other.runtimeType &&
          customer_id == other.customer_id &&
          first_name == other.first_name &&
          last_name == other.last_name &&
          email == other.email &&
          gender == other.gender &&
          phone == other.phone &&
          document_id == other.document_id &&
          pushNotification == other.pushNotification &&
          verifiedNumber == other.verifiedNumber &&
          isVerifiedEmail == other.isVerifiedEmail;

  @override
  int get hashCode =>
      customer_id.hashCode ^
      first_name.hashCode ^
      last_name.hashCode ^
      email.hashCode ^
      gender.hashCode ^
      phone.hashCode ^
      document_id.hashCode ^
      pushNotification.hashCode ^
      verifiedNumber.hashCode ^
      isVerifiedEmail.hashCode;

  factory AccountInfoResponse.fromMap(Map<String, dynamic> map) {
    print(map);
    return AccountInfoResponse(
      pushNotification: map["pushNotification"]?.toString() == "true",
      verifiedNumber: map["verifiedNumber"]?.toString() == "true",
      isVerifiedEmail: map["isVerifiedEmail"]?.toString() == "true",
      customer_id: map['customer_id'] as String,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      phone: Phone.fromMap(map['phone']),
      document_id: map['document_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      "pushNotification": this.pushNotification,
      "verifiedNumber": this.verifiedNumber,
      'customer_id': this.customer_id,
      'first_name': this.first_name,
      'last_name': this.last_name,
      'email': this.email,
      'gender': this.gender,
      'phone': this.phone.toMap(),
      'document_id': this.document_id,
      "isVerifiedEmail": this.isVerifiedEmail,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}

class Phone {
  final String principal;
  final String other;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Phone({
    this.principal,
    this.other,
  });

  Phone copyWith({
    String principal,
    String other,
  }) {
    if ((principal == null || identical(principal, this.principal)) &&
        (other == null || identical(other, this.other))) {
      return this;
    }

    return Phone(
      principal: principal ?? this.principal,
      other: other ?? this.other,
    );
  }

  @override
  String toString() {
    return 'Phone{principal: $principal, other: $other}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Phone &&
          runtimeType == other.runtimeType &&
          principal == other.principal &&
          other == other.other);

  @override
  int get hashCode => principal.hashCode ^ other.hashCode;

  factory Phone.fromMap(Map<String, dynamic> map) {
    return Phone(
      principal: map['principal'] as String,
      other: map['other'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'principal': this.principal,
      'other': this.other,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
