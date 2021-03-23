import 'package:flutter/material.dart';

class Vazio extends StatelessWidget {

  const Vazio({
    Key key,
    this.title = 'Nada ainda',
    this.message = 'Adicione um dispositivo para começar',
  }) : super(key: key);
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50),
        Text(
          title,
        ),
        SizedBox(height: 50),
        Text(
          message,
        ),
      ],
    );
  }
}
