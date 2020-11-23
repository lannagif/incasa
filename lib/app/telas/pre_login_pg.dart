import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incasa/app/telas/home_pg.dart';
import 'package:incasa/app/telas/login_pg.dart';


class PreLogin extends StatefulWidget {
  @override
  _PreLoginState createState() => _PreLoginState();
}

class _PreLoginState extends State<PreLogin> {

  Color corPrimaria = Colors.yellow[300];
  Color corSecundaria = Colors.yellow[200];
  Color corLogo = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrimaria,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //We take the image from the assets
            // Image.asset(
            //   'assets/splash-image.png',
            //   height: 250,
            // ),
            Center(
              child: Icon(
                FontAwesomeIcons.houseUser,
                size: 120,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            //Texts and Styling of them
            Text(
              'Bem vindo ao InCasa!',
              textAlign: TextAlign.center,
              style: TextStyle(color: corLogo, fontSize: 28),
            ),
            SizedBox(height: 20),
            Text(
              'Uma aplicação para casa inteligente',
              textAlign: TextAlign.center,
              style: TextStyle(color: corLogo, fontSize: 16),
            ),
            SizedBox(
              height: 30,
            ),
            //Our MaterialButton which when pressed will take us to a new screen named as
            //LoginScreen
            MaterialButton(
              elevation: 0,
              height: 50,

              onPressed: () {
                   Navigator.push(context,
                       MaterialPageRoute(builder: (_) => HomePg()));
              },
              color: corLogo,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Começar',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  SizedBox(width: 10.0,),
                  Icon(
                    FontAwesomeIcons.solidArrowAltCircleRight,
                    color: Colors.white,
                  ),
                ],
              ),
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
