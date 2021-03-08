import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_verification/provider/_providers.dart';
import 'package:sms_verification/view/page/account/account_page.dart';

void main() {
  Provider.debugCheckInvalidValueType = <T>(T value) {
    return true;
  };

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light().copyWith(
          primaryColor: Color.fromRGBO(109, 174, 66, 1),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: AccountPage(),
      ),
    );
  }
}