/*

import 'package:flutter/material.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddTipoDispositivo extends StatefulWidget {

  //final Dispositivo dispositivo;
  //AddTipoDispositivo({Key key, @required this.dispositivo}) : super(key: key);


  @override
  _AddTipoDispositivoState createState() => _AddTipoDispositivoState();
}

class _AddTipoDispositivoState extends State<AddTipoDispositivo> {
  var selectedDispositivo;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tipoDispositivo').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Text('Loading');
        } else {
          List<DropdownMenuItem> dispositivoItems = [];
          for (int i=0; i< snapshot.data.docs.length; i++){
            DocumentSnapshot snap=snapshot.data.docs[i];
            dispositivoItems.add(
                DropdownMenuItem(
                  child: Text(
                    snap.id,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: "${snap.id}",
                )
            );
          }
          return DropdownButton(
            iconSize: 40,
            dropdownColor: Colors.grey[800],
            isExpanded: true,
            items: dispositivoItems,
            onChanged: (dispositivoTipo){
              setState(() {
                selectedDispositivo = dispositivoTipo;

              });
            },
            value: selectedDispositivo,
          );
        }
      },
    );
  }
}
*/
