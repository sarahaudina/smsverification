import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sms_verification/view/widget/dialog/snackbar.dart';

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
    if (e is DioError) {
      print(e.request.path);
    }
    print(e);
    Navigator.pop(context);
    showSnackBar(context, e is DioError ? e.message : e.toString());
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
