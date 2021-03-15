import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_verification/movas/observable/sms_verification_response.dart';

List<SingleChildWidget> streamProviders = [
  Provider<PublishSubject<SmsVerificationResponse>>(
    lazy: false,
    create: (context) => PublishSubject(sync: true),
    dispose: (_, stream) => stream.close(),
  ),
];