import 'package:flutter/material.dart';
import 'package:incasa/app/components/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:incasa/app/telas/landing_pg.dart';
//import 'package:incasa/app/telas/login_pg.dart';
//import 'package:incasa/app/telas/pre_login_pg.dart';
import 'package:provider/provider.dart';
import 'package:incasa/app/servicos/autenticacao.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Provider<BaseAutenticacao>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'InCasa',
        theme: ThemeData(
          //primarySwatch: Colors.yellow,
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: LandingPg(auth: Auth()),
      ),
    );
  }
}

/*
return Provider<AuthBase>(
create: (context) => Auth(),
child: MaterialApp(
debugShowCheckedModeBanner: false,
title: 'InCasa',
theme: ThemeData(
primarySwatch: Colors.yellow,
),
home: Origem(
databaseBuilder: (uid) => FirestoreDatabase(uid: uid),
),
),*/
