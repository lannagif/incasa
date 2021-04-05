import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:incasa/app/components/switch_on_off.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';
import 'package:incasa/app/components/const.dart';
import 'package:incasa/app/services/firestore_service.dart';

class CardDispositivo extends StatelessWidget {

  const CardDispositivo({Key key, @required this.dispositivo, this.onTap}) : super(key: key);

  final Dispositivo dispositivo;
  final VoidCallback onTap;

  //int _estado;


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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Image.asset('assets/imgs/lamp.png', height: 110)),
                Expanded(
                  flex: 4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Spacer(),
                        ListTile(

                          title: Text(dispositivo.tag??''),
                          subtitle: Text(dispositivo.tipo+' '+dispositivo.comodo??''),
                          onTap: onTap,
                        ),
                        //Spacer(),
                      ]
                  ),
                ),
                Expanded(flex: 2,
                    child: SwitchOnOff(dispositivo: dispositivo,)),
              ],
            ),
          )
      ),
    );
  }
}
