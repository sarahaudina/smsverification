import 'package:movas/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sms_verification/observable/default_theme.dart';
import 'package:sms_verification/observable/theme_observable.dart';
import 'package:sms_verification/service/sms_verification/sms_verification/sms_verification_response.dart';
import 'package:sms_verification/service/sms_verification/sms_verification_service.dart';
import 'package:sms_verification/service/sms_verification/test_sms_verification_service.dart';
import 'package:sms_verification/service/account_info_service.dart';
import 'package:sms_verification/store/account_info_store.dart';
import 'package:sms_verification/store/sms_verification_store.dart';
import 'package:sms_verification/store/theme_model.dart';

List<SingleChildWidget> providers = [
  Provider<SmsVerificationService>(
    create: (context) => TestSmsVerificationService(
      StaticProvider.of(context),
    ),
  ),
  Provider<AccountInfoService>(
    create: (context) => AccountInfoService(
      StaticProvider.of(context),
    ),
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
  Provider<AccountInfoStore>(
    lazy: false,
    create: (context) {
      return AccountInfoStore(
        StaticProvider.of(context),
      );
    },
    dispose: (_, store) => store.dispose(),
  ),
];
