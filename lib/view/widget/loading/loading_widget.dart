import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_verification/observable/theme_observable.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeO>(
      builder: (_, themeO, __) => Container(
        color: themeO.loadingBackgroundColor,
        child: LoadingWidget(),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeO>(
      builder: (_, theme, __) => Stack(
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 160,
              height: 160,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.loadingIndicatorColor,
                ),
              ),
            ),
          ),
          Center(
              child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/logo_lima_no_border.png'))),
        ],
      ),
    );
  }
}
