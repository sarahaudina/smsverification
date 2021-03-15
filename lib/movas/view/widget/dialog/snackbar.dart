import 'dart:async';

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: Duration(seconds: 2),
    ),
  );
}