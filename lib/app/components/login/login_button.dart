import 'package:flutter/material.dart';
import 'package:incasa/app/servicos/autenticacao.dart';

class LoginButton extends StatelessWidget {

  final Color color;
  final Color fontColor;
  final String logo;
  final String text;
  final BaseAutenticacao metodo;
  final PageController controller;

  LoginButton(this.color, this.fontColor, this.logo, this.text, this.metodo, this.controller);


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      minWidth: double.maxFinite,
      height: 50,
      onPressed: () async {

      },
      color: color,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Icon(FontAwesomeIcons.mailBulk,
            //color: Colors.white,
            //),

            Image.asset(logo.toString()),
            SizedBox(width: 15),
            Text(text,
                style: TextStyle(color: fontColor, fontSize: 18.0)),
          ]
      ),
      textColor: fontColor,
    );
  }
}
