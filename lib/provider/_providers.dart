import 'package:movas/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'file:///D:/personal/sms_verification/lib/movas/observable/theme/default_theme.dart';
import 'package:sms_verification/movas/observable/theme/theme_observable.dart';
import 'package:sms_verification/movas/observable/smsverification/sms_verification_response.dart';
import 'package:sms_verification/movas/service/sms_verification/sms_verification_service.dart';
import 'package:sms_verification/movas/service/sms_verification/test_sms_verification_service.dart';
import 'package:sms_verification/movas/store/theme_model.dart';

List<SingleChildWidget> providers = [
  Provider<PublishSubject<SmsVerificationResponse>>(
    lazy: false,
    create: (context) => PublishSubject(sync: true),
    dispose: (_, stream) => stream.close(),
  ),
  StoreProvider<ThemeStore, ThemeO>(
    storeBuilder: (context) => ThemeStore(
      TraeteloDefaultTheme(),
    ),
  ),
  Provider<SmsVerificationService>(
    create: (context) => TestSmsVerificationService(
      StaticProvider.of(context),
    ),
  ),
];
