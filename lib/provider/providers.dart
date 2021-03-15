import 'package:provider/single_child_widget.dart';
import 'package:sms_verification/provider/service_provider.dart';
import 'package:sms_verification/provider/stream_provider.dart';
import 'package:sms_verification/provider/store_provider.dart';

List<SingleChildWidget> providers = [
  ...streamProviders,
  ...serviceProviders,
  ...storeProviders
];
