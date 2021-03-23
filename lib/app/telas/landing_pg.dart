import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:incasa/app/components/header_info.dart';
import 'package:incasa/app/servicos/database.dart';
import 'package:incasa/app/telas/home_pg.dart';
import 'package:incasa/app/servicos/autenticacao.dart';
import 'package:provider/provider.dart';
import 'package:incasa/app/telas/email_login_pgs/sign_in_page.dart';

class LandingPg extends StatelessWidget {

  //LandingPg({Key key, @required this.databaseBuilder}) : super(key:key);
  //final Database Function(String) databaseBuilder;

  //LandingPg({@required this.auth});
  //final BaseAutenticacao auth;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<BaseAutenticacao>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          User user = snapshot.data;
          if (user == null){
            return SignInPage.create(context);
          }
          return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: HomePg(
                //auth: auth,
              ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
            ),
          ),
        );
      }
    );
  }
}
