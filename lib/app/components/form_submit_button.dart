import 'package:flutter/material.dart';
import 'package:incasa/app/components/custom_raised_button.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
    child: Text(
      text,
      style: TextStyle(color: Colors.redAccent, fontSize: 20.0),
    ),
    height: 44.0,
    color: Colors.black,
    borderRadius: 4.0,
    onPressed: onPressed,
  );
}