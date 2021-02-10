import 'package:flutter/material.dart';
import 'package:incasa/app/components/custom_raised_button.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    Key key,
    @required String text,
    String assetName,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : assert(text != null),
        super(
        key: key,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(assetName),
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: 20.0),
            ),
            Opacity(
              opacity: 0.0,
              child: Image.asset(assetName),
            ),
          ],
        ),
        color: color,
        onPressed: onPressed,
      );
}