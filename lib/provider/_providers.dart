import 'package:movas/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sms_verification/service/sms_verification/sms_verification_service.dart';
import 'package:sms_verification/service/sms_verification/test_sms_verification_service.dart';

List<SingleChildWidget> providers = [
  Provider<SmsVerificationService>(
    create: (context) => TestSmsVerificationService(
      StaticProvider.of(context),
    ),
  ),

];
