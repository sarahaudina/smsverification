import 'package:flutter/material.dart';
import 'package:movas/config/config.dart';
import 'package:provider/provider.dart';
import 'package:sms_verification/provider/providers.dart';
import 'package:sms_verification/movas/view/page/account/account_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  moveAss(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light().copyWith(
          primaryColor: Color.fromRGBO(200, 100, 66, 1),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: AccountPage(),
      ),
    );
  }
}