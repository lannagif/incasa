import 'package:flutter/material.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';

class AddTag extends StatelessWidget {
  final Dispositivo dispositivo;
  AddTag({Key key, @required this.dispositivo}) : super(key: key);

  @override
  Widget build(BuildContext context){
    TextEditingController _tagController = TextEditingController();
    _tagController.text = dispositivo.tag;

    return TextFormField(
      controller: _tagController,
      style: Theme.of(context).textTheme.headline5.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
        //TextStyle(fontSize: 20, color: Colors.white),
      decoration: const InputDecoration(
        hintText: 'i.e. Lâmpada 1 | Cortina da Sala | etc',
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }
}

