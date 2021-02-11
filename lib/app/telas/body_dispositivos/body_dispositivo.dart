import 'package:flutter/material.dart';
import 'package:incasa/app/components/dispositivos/dispositivo_cards.dart';
import 'package:incasa/app/components/title_with_add_button.dart';



class BodyDispositivos extends StatelessWidget {

  //final _pageControler = PageController();

  @override
  Widget build(BuildContext context) {

    //Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SizedBox(height: 120),
          TitleWithAdd(text: 'Dispositivos', press: (){},),
          SizedBox(height: 5),
          DispositivoCards(),
        ],
      ),
    );
  }
}




