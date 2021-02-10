import 'package:flutter/material.dart';
import 'package:incasa/app/components/show_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> showExceptionAlertDialog(
    BuildContext context, {
      @required String title,
      @required dynamic exception,
    }) =>
    showAlertDialog(
      context,
      title: title,
      content: _message(exception),
      defaultActionText: 'OK',
    );

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return ('Confira se o endereço de email e a senha foram inseridos corretamente.').toString(); //exception.message;
  }
  return exception.toString();
}
