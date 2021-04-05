import 'package:flutter/material.dart';
import 'package:incasa/app/components/HomePgProvider/home_pg_provider.dart';
import 'package:incasa/app/components/dispositivos/estado_dispositivo_provider.dart';
import 'package:incasa/app/components/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:incasa/app/components/header_info.dart';
import 'package:incasa/app/telas/home_pg.dart';
//import 'package:incasa/app/telas/wifi_config/wifi_info_esp.dart';
//import 'package:incasa/app/telas/wifi_config/wifi_info_pg.dart';
import 'package:incasa/app/telas/landing_pg.dart';
import 'package:provider/provider.dart';
import 'package:incasa/app/services/autentication.dart';
import 'package:incasa/app/telas/wifi_config/wifi_manager.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthBase>(
            create: (context) => Auth(),
          ),
          ChangeNotifierProvider(
              create: (context) => HeaderInfo(),
          ),
          Provider<WifiInfoSsidPwd>(
               create: (context) => WifiInfoSsidPwd(),
           ),
          ChangeNotifierProvider(
            create: (context) => HomePgProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => EstadoDispositivo(),
          ),
          //ChangeNotifierProvider(
          //    create: (context) => WifiInfoSsidPwd(),
          //),
        ],
        child: MaterialApp(
        title: 'InCasa',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: LandingPg(),
      ),)
    ;
  }
}

