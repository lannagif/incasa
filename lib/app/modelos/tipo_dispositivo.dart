import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:incasa/app/components/const.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';
import 'package:incasa/app/modelos/addDispositivo/addComodo.dart';
import 'package:incasa/app/modelos/addDispositivo/addTipoDispositivo.dart';
//import 'package:incasa/app/modelos/addDispositivo/addTag.dart';
import 'package:incasa/app/servicos/autenticacao.dart';
import 'package:incasa/app/servicos/database.dart';

class AddDisp extends StatefulWidget {

  @override
  _AddDispState createState() => _AddDispState();
}

class _AddDispState extends State<AddDisp> {

  //final db = FirebaseFirestore.instance;


  //Dispositivo dispositivo = Dispositivo('a','b', 'c');
  //_AddDispState({@required this.dispositivo});

  Future<void> _createDispositivo(BuildContext context) async {
    try{
      final database = Provider.of<Database>(context, listen: false);
      await database.createDispositivo(Dispositivo(tipo: 'Lâmpada', comodo: 'sala'));
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialButton(
      color: kTextColor,
      elevation: 0,
      child: Icon(
        Icons.add,
        size: 20.0,
        color: kPrimaryColor,
      ),
      onPressed: (){
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                scrollable: true,
                backgroundColor: Colors.black87,
                insetPadding: EdgeInsets.all(32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(36)),),
                content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState){
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0,10),
                              blurRadius: 40,
                              color: kTextColor.withOpacity(0.2),
                            ),
                          ]
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 20),
                          Text('Novo Dispositivo',
                            style: Theme.of(context).textTheme.headline4.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 35,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Qual o tipo?',
                              style: Theme.of(context).textTheme.headline6.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          SizedBox(height: 20),
                          //AddTipoDispositivo(),
                          SizedBox(height: 35),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Onde?',
                              style: Theme.of(context).textTheme.headline6.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          SizedBox(height: 20),
                          //AddComodo(),
                          SizedBox(height: 35),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Tag',
                              style: Theme.of(context).textTheme.headline6.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          //AddTag(dispositivo: Dispositivo(null,null,'L1'),),
                          SizedBox(height: 40),
                          Column(
                            children: [
                              MaterialButton(
                                shape: CircleBorder(),
                                color: kPrimaryColor,
                                elevation: 0,
                                child: Icon(
                                    Icons.add,
                                    size: 20.0,
                                    color: Colors.black,
                                ),
                                onPressed: () => _createDispositivo(context),
                                /*
                                onPressed: () async {
                                  builder: (context) {
                                    return _createDispositivo(context);
                                  },
                                  Navigator.of(context, rootNavigator: true).pop();
                                },*/
                                //{
                                  //
                                //},
                              ),
                              Text('Adicionar',
                                style: TextStyle(fontSize: 15, color: kPrimaryColor),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                  },
                ),
                //title:
              );
            });
      },
      shape: CircleBorder(),
    );
  }


}


