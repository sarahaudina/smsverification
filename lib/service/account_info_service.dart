import 'package:rxdart/rxdart.dart';

import 'http/account_info_response.dart';
import 'http/update_account_info_request.dart';
import 'http/user_mobile_verification_request.dart';

class AccountInfoService {
  PublishSubject<AccountInfoResponse> accountInfoResponse$;

  AccountInfoService(this.accountInfoResponse$);

  Future<AccountInfoResponse> getAccountInfo() async {
    // final accountInfoResponse = await _httpService.post(
    //     request: req,
    //     converter: (response) {
    //       print(response);
    //       return AccountInfoResponse.fromMap(response['data']);
    //     });
    //
    // accountInfoResponse$.add(accountInfoResponse);
    // return accountInfoResponse;
  }

  Future<void> updateAccountInfo(UpdateAccountInfoRequest req) async {
    // final accountInfoResponse = await _httpService.post(
    //     request: req,
    //     converter: (response) => AccountInfoResponse.fromMap(response['data']));
    //
    // return accountInfoResponse$.add(accountInfoResponse);
  }

  Future<void> updatePhoneVerificationStatus(UserMobileVerificationRequest req) async {
    // final accountInfoResponse = await _httpService.post(
    //     request: req,
    //     converter: (response) => AccountInfoResponse.fromMap(response['data']));
    //
    // return accountInfoResponse$.add(accountInfoResponse);
  }

  void dispose() {
    accountInfoResponse$.close();
  }
}
