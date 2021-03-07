
import 'base_http_request.dart';

class UpdateAccountInfoRequest extends BaseHttpRequest {
  final String countryId;
  final String customerId;
  final String type;
  final String firstName;
  final String lastName;
  final String email;
  final String emailConfirm;
  final String gender;
  final String phone;
  final String docID;

  UpdateAccountInfoRequest({
    this.countryId,
    this.customerId,
    this.type,
    this.firstName,
    this.lastName,
    this.email,
    this.emailConfirm,
    this.gender,
    this.phone,
    this.docID,
  }) : super(endpoint: "/accountinfo");

  factory UpdateAccountInfoRequest.fromMap(
    Map<String, dynamic> map, {
    String countryID,
    String customerID,
  }) {
    return new UpdateAccountInfoRequest(
      countryId: countryID,
      customerId: customerID,
      type: 'update',
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String,
      emailConfirm: map['email'] as String,
      gender: map['gender'] as String,
      phone: map['principal'] as String,
      docID: map['document_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'countryId': this.countryId,
      'customerId': this.customerId,
      'type': this.type,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'emailConfirm': this.emailConfirm,
      'gender': this.gender,
      'phone': this.phone,
      'docID': this.docID,
    } as Map<String, dynamic>;
  }
}
