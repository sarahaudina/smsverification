import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/service/http/account_info_response.dart';

class AccountInfoStore {
  BehaviorSubject<AccountInfoO> accountInfoO$ = BehaviorSubject();

  AccountInfoStore(PublishSubject<AccountInfoResponse> response$) {
    response$.listen((value) {
      accountInfoO$.add(AccountInfoO(response: value));
    });
  }

  void dispose() {
    accountInfoO$.close();
  }
}

class AccountInfoO {
  AccountInfoResponse response;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  AccountInfoO({
    this.response,
  });

  AccountInfoO copyWith({
    AccountInfoResponse response,
  }) {
    return new AccountInfoO(
      response: response ?? this.response,
    );
  }

  @override
  String toString() {
    return 'AccountInfoO{response: $response}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountInfoO &&
          runtimeType == other.runtimeType &&
          response == other.response);

  @override
  int get hashCode => response.hashCode;

  factory AccountInfoO.fromMap(Map<String, dynamic> map) {
    return new AccountInfoO(
      response: map['response'] as AccountInfoResponse,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'response': this.response.toMap(),
    } as Map<String, dynamic>;
  }

  Map<String, dynamic> responseMap() {
    return this.response.toMap();
  }

//</editor-fold>

}
