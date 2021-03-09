//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:incasa/app/modelos/tipo_dispositivo.dart';
//import 'package:provider/provider.dart';
import 'package:incasa/app/components/const.dart';
//import 'package:incasa/app/modelos/dispositivo_modelo.dart';
//import 'package:incasa/app/components/show_exception_alert_dialog.dart';
//import 'package:incasa/app/servicos/autenticacao.dart';
//import 'package:incasa/app/servicos/database.dart';

class NovoDispositivo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: kTextColor,
      elevation: 0,
      child: Icon(
        Icons.add,
        size: 20.0,
        color: kPrimaryColor,
      ),
      onPressed: () => AddDisp.show(context),
      shape: CircleBorder(),
    );
  }

}
