import 'package:flutter/material.dart';
import 'package:incasa/app/components/const.dart';

class Texto extends StatefulWidget {
  @override
  _TextoState createState() => _TextoState();
}

class _TextoState extends State<Texto> {

  final nameController = TextEditingController();

  /*
  @override
  void dispose(){
    nameController.dispose();
    super.dispose();
  }
  */

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Row(
        children: [
          widgetTextField(),
        ],
      ),
    );
  }
  widgetTextField(){
    return Flexible(
      flex: 1,
      child: Container(
        color: kPrimaryColor,
        child: Padding(padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: nameController,
            style: Theme.of(context).textTheme.headline5.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'morador(a)',
                fillColor: kTextColor,
            ),
          ),
        ),
      ),
    );
  }
}

