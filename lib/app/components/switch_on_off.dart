import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class SwitchOnOff extends StatefulWidget {
  @override
  _SwitchOnOffState createState() => _SwitchOnOffState();
}

class _SwitchOnOffState extends State<SwitchOnOff> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 30,),
        Transform.scale(
          scale: 2.5,
          child: GFToggle(
            onChanged: (val){},
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
    );
  }
}

