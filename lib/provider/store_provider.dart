import 'package:provider/single_child_widget.dart';
import 'package:movas/provider/provider.dart';
import 'package:sms_verification/movas/observable/sms_verification_response.dart';
import 'package:sms_verification/movas/store/sms_verification_store.dart';

List<SingleChildWidget> storeProviders = [
  StoreProvider<SmsVerificationStore, SmsVerificationResponse>(
    storeBuilder: (context) => SmsVerificationStore(
        StaticProvider.of(context)
    ),
  ),
];