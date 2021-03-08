import 'package:movas/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/observable/default_theme.dart';
import 'package:sms_verification/observable/theme_observable.dart';
import 'package:sms_verification/service/sms_verification/sms_verification/sms_verification_response.dart';
import 'package:sms_verification/service/sms_verification/sms_verification_service.dart';
import 'package:sms_verification/service/sms_verification/test_sms_verification_service.dart';
import 'package:sms_verification/store/sms_verification_store.dart';
import 'package:sms_verification/store/theme_model.dart';

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
  StoreProvider<SmsVerificationStore, SmsVerificationResponse>(
    storeBuilder: (context) => SmsVerificationStore(
      StaticProvider.of(context),
    ),
  ),
  Provider<SmsVerificationService>(
    create: (context) => TestSmsVerificationService(
      StaticProvider.of(context),
    ),
  ),
];
