import 'package:flutter/material.dart';
import 'package:incasa/app/components/title_with_add_button.dart';
import 'package:incasa/app/components/comodos/comodo_cards.dart';

class BodyComodos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SizedBox(height: 120),
          TitleWithAdd(text: 'Cômodos'), //press: (){},),
          SizedBox(height: 5),
          ComodoCards(),
        ],
      ),
    );
  }
}




