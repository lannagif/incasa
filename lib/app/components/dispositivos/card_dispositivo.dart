import 'package:flutter/material.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';
import 'package:incasa/app/components/const.dart';


class CardDispositivo extends StatelessWidget {

  const CardDispositivo({Key key, @required this.dispositivo, this.onTap}) : super(key: key);

  final Dispositivo dispositivo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(36)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0,10),
                blurRadius: 40,
                color: kTextColor.withOpacity(0.2),
              ),
            ]
        ),
        child: ListTile(
          leading: Image.asset('assets/imgs/lamp.png'),
          title: Text(dispositivo.tag??''),
          subtitle: Text(dispositivo.tipo+' '+dispositivo.comodo??''),
          onTap: onTap,
          trailing: chave(),
        ),
      ),
    );
  }

  Widget chave() {

  }
}

