import 'package:movas/provider/provider.dart';
import 'package:sms_verification/service/account_info_service.dart';
import 'package:sms_verification/service/http/account_info_response.dart';
import 'package:sms_verification/service/http/update_account_info_request.dart';

class AccountInfoAction {
  final AccountInfoService _accountInfoService;

  AccountInfoAction(this._accountInfoService);

  factory AccountInfoAction.of(context) => AccountInfoAction(
        StaticProvider.of(context),
      );

  Future<AccountInfoResponse> fetchAccountInfo() {
    // return _accountInfoService.getAccountInfo(AccountInfoRequest(
    //     countryId: 229,
    //     customerId: _customerStore.currentCustomer.customer_id,
    //     type: 'view'));
  }

  Future<void> updateAccountInfo(Map<String, dynamic> map) {
    // return _accountInfoService.updateAccountInfo(
    //     UpdateAccountInfoRequest.fromMap(map,
    //         countryID: "229",
    //         customerID: _customerStore.currentCustomer.customer_id));
  }

  Future<void> updatePhoneVerificationStatus({bool verified}) async {
    // return _accountInfoService.updatePhoneVerificationStatus(
    //   UserMobileVerificationRequest(
    //     action: "verifyPhone",
    //     customerId: _customerStore.currentCustomer.customer_id,
    //     verified: verified,
    //   ),
    // );
  }
}
