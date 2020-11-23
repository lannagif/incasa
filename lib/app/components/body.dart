import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:incasa/app/components/const.dart';
import 'package:incasa/app/components/header.dart';
import 'package:incasa/app/components/title_with_add_button.dart';
import 'comodo_cards.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SizedBox(height: 10),
          TitleWithAdd(text: 'Cômodos', press: (){},),
          SizedBox(height: 5),
          ComodoCards(),
        ],
      ),
    );
  }
}




