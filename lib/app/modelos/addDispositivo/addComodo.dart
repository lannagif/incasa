import 'package:flutter/material.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddComodo extends StatefulWidget {

  final Dispositivo dispositivo;
  AddComodo({Key key, @required this.dispositivo}) : super(key: key);

  @override
  _AddComodoState createState() => _AddComodoState();
}

class _AddComodoState extends State<AddComodo> {
  var selectedDispositivo;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('comodoDispositivo').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Text('Loading' );
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
            onChanged: (dispositivoComodo){
              setState(() {
                selectedDispositivo = dispositivoComodo;
              });
            },
            value: selectedDispositivo,
          );
        }
      },
    );
  }
}
