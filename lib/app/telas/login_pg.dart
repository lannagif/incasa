import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:incasa/app/servicos/autenticacao.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:incasa/app/components/const.dart';

class LoginPg extends StatefulWidget {
  @override
  _LoginPgState createState() => _LoginPgState();
}

class _LoginPgState extends State<LoginPg> {

  Color corPrimaria = kPrimaryColor;
  Color corSecundaria = kPrimaryColor;
  Color corLogo = Colors.black;


  final TextEditingController nomeController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        backgroundColor: corPrimaria,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'InCasa',
                  textAlign: TextAlign.center,
                  style:
                  GoogleFonts.openSans(color: corLogo, fontSize: 28),
                ),
                SizedBox(height: 20),
                Text(
                  'Insira suas credenciais abaixo, ou crie uma conta usando email.',
                  textAlign: TextAlign.center,
                  style:
                  GoogleFonts.openSans(color: corLogo, fontSize: 14),
                ),
                SizedBox(
                  height: 50,
                ),
                // SizedBox(
                //   height: 50.0,
                //   child: _buildHeader(),
                // ),
                _buildTextField(
                    nomeController, 'Email'),
                SizedBox(height: 20),
                _buildTextField(senhaController, 'Senha'),
                SizedBox(height: 30),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () async {

                  },
                  color: corLogo,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Icon(FontAwesomeIcons.mailBulk,
                      color: Colors.white,
                    ),
                    SizedBox(width: 15),
                    Text('Login com email',
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  ]
                  ),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () async {

                      // final GoogleSignInAccount googleUser = await googleSignIn.signIn();
                      // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                      //
                      // final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
                      //
                      // final User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;


                  },
                  color: corLogo,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.google,
                      color: Colors.white,),
                      SizedBox(width: 15),
                      Text('Entrar com o Google',
                          style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    ],
                  ),
                  textColor: Colors.white,
                ),
                SizedBox(height: 100),

              ],
            ),
          ),
        ));
  }



  _buildTextField(
      TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: corSecundaria, border: Border.all(color: corLogo)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: corLogo),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: corLogo),

            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
}

/*
Widget _buildHeader() {
  if (isLoading) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  return Text(
    'Entre',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
    ),
  );
}*/
