import 'package:flutter/material.dart';
import 'package:incasa/app/components/custom_raised_button.dart';


//Cria botão para 'Entrar com o Google' genérico

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(assetName != null),
        assert(text != null),
        super(
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
