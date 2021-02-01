import 'package:flutter/material.dart';
import 'package:incasa/app/components/dispositivo_cards.dart';
import 'package:incasa/app/components/title_with_add_button.dart';



class BodyDispositivos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SizedBox(height: 10),
          TitleWithAdd(text: 'Dispositivos', press: (){},),
          SizedBox(height: 5),
          DispositivoCards(),
        ],
      ),
    );
  }
}




