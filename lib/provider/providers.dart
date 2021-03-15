import 'package:provider/single_child_widget.dart';
import 'package:movas/provider/provider.dart';
import 'package:sms_verification/movas/observable/sms_verification_response.dart';
import 'package:sms_verification/movas/store/sms_verification_store.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/movas/service/sms_verification/sms_verification_service.dart';
import 'package:sms_verification/movas/service/sms_verification/test_sms_verification_service.dart';

List<SingleChildWidget> providers = [
  Provider<PublishSubject<SmsVerificationResponse>>(
    lazy: false,
    create: (context) => PublishSubject(sync: true),
    dispose: (_, stream) => stream.close(),
  ),
  Provider<SmsVerificationService>(
    create: (context) => TestSmsVerificationService(
      StaticProvider.of(context),
    ),
  ),
  StoreProvider<SmsVerificationStore, SmsVerificationResponse>(
    storeBuilder: (context) => SmsVerificationStore(
        StaticProvider.of(context)
    ),
  ),
];
