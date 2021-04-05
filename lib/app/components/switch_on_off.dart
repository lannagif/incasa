import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:incasa/app/services/database.dart';
import 'package:incasa/app/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';

class SwitchOnOff extends StatefulWidget {

  const SwitchOnOff({Key key, @required this.dispositivo, this.onTap}) : super(key: key);

  final Dispositivo dispositivo;
  final VoidCallback onTap;

  @override
  _SwitchOnOffState createState() => _SwitchOnOffState();
}

class _SwitchOnOffState extends State<SwitchOnOff> {

  //Dispositivo dispositivo;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 30,),
        Transform.scale(
          scale: 1.8,
          child: GFToggle(
            onChanged: (estado){
              widget.dispositivo.estado = estado ? 1 : 0;
              database.setDispositivo(widget.dispositivo);
            },
            value:  widget.dispositivo.estado ?? false,
            type: GFToggleType.custom,
            disabledText: "",
            enabledText: "",
            enabledTrackColor: Colors.yellow[100],
            disabledTrackColor: Colors.black45,
            enabledThumbColor: Colors.white,
            disabledThumbColor: Colors.black,
            boxShape: BoxShape.rectangle,
            borderRadius: BorderRadius.zero,
            duration: Duration(milliseconds: 1),
          ),
        ),
      ],
    );
    }
}

/*
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
SizedBox(width: 30,),
Transform.scale(
scale: 1.8,
child: GFToggle(
onChanged: (val){

},
value: null,
type: GFToggleType.custom,
disabledText: "",
enabledText: "",
enabledTrackColor: Colors.yellow[100],
disabledTrackColor: Colors.black45,
enabledThumbColor: Colors.white,
disabledThumbColor: Colors.black,
boxShape: BoxShape.rectangle,
borderRadius: BorderRadius.zero,
duration: Duration(milliseconds: 1),
),
),
],
);*/
