import 'dart:async';

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  Scaffold.of(context).showCustomSnackbar(
    SnackBar(
      content: Text(text),
      duration: Duration(seconds: 2),
    ),
  );
}

extension CustomSnackbar on ScaffoldState {
  showCustomSnackbar(SnackBar snackbar) {
    var customSnackbar = this.showSnackBar(snackbar);
    Timer(snackbar.duration, () => this.hideCurrentSnackBar());
    return customSnackbar;
  }
}

class ErrorPopup extends StatelessWidget {
  final String title, bottomText, bodyText;

  const ErrorPopup({
    @required this.title,
    @required this.bottomText,
    @required this.bodyText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFBE1E1),
              borderRadius: BorderRadius.circular(40),
            ),
            constraints: BoxConstraints(maxHeight: 500, minHeight: 200),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Align(
                          child: Container(
                            height: 30,
                            width: 30,
                            child: Icon(Icons.close),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                    color: Color(
                                      0xffE76767,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    bodyText,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Color(0xffE76767), fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: bottomText?.isNotEmpty??false,
                  child: Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        bottomText,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Color(0xffE76767), fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 70,
        ),
      ],
    );
  }
}
