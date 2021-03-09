import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sms_verification/movas/view/widget/dialog/snackbar.dart';

import 'loading_widget.dart';

Future<void> showLoadingDialog(BuildContext context, [Widget child]) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingWidget());
}

Future<T> loadingActionHandler<T>(BuildContext context, Future<T> actionFuture,
    [Widget child]) async {
  showLoadingDialog(context, child);
  return actionFuture.then((value) {
    Navigator.pop(context);
    return value;
  }).catchError((e) {
    print(e);
    Navigator.pop(context);
    showSnackBar(context, e.toString());
    throw e;
  });
}

Future<T> loadingActionHandlerCustomError<T>(
    BuildContext context, Future<T> actionFuture, Function onError(dynamic e),
    [Widget child]) async {
  showLoadingDialog(context, child);
  return actionFuture.then((value) {
    Navigator.pop(context);
    return value;
  }).catchError((e) {
    onError(e);
    throw e;
  });
}
