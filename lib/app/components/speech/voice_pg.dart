import 'package:flutter/material.dart';
import 'package:incasa/app/components/speech/speech_pg.dart';
import 'package:incasa/app/components/title_with_add_button.dart';


class VoiceMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[

        SizedBox(height: 120),
        TitleWithAdd(text: 'Modo Voz'), //press: (){},),
        SizedBox(height: 5),
        SpeechScreen(),
      ],
    );
  }


}




