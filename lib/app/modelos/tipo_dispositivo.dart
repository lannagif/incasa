import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:incasa/app/components/show_alert_dialog.dart';
import 'package:incasa/app/components/show_exception_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:incasa/app/components/const.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';
//import 'package:incasa/app/modelos/addDispositivo/addComodo.dart';
//import 'package:incasa/app/modelos/addDispositivo/addTipoDispositivo.dart';
//import 'package:incasa/app/modelos/addDispositivo/addTag.dart';
import 'package:incasa/app/servicos/autenticacao.dart';
import 'package:incasa/app/servicos/database.dart';

class AddDisp extends StatefulWidget {

  const AddDisp({Key key, @required this.database}) : super(key: key);
  final Database database;

  static Future<void> show(BuildContext context) async {
    // context of dispositivos page
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryanimation) => AddDisp(database: database,),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddDispState createState() => _AddDispState();
}

class _AddDispState extends State<AddDisp> {

  final _formKey = GlobalKey<FormState>();

  String _tipo;
  String _comodo;
  String _tag;

  var selectedDispositivo;
  var selectedComodo;

  bool _validadeAndSaveForm(){
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }



  Future<void> _enviarDispositivo() async {
    if(_validadeAndSaveForm()){
      //print('form salvo: tipo - $_tipo, comodo: $_comodo, tag: $_tag');
      //enviar para o Firestore
      // context de AddDisp
      //final database = Provider.of<Database>(context, listen: false);
      try {
        final dispositivos = await widget.database.dispositivoStream().first;
        final allTags = dispositivos.map((dispositivo) => dispositivo.tag).toList();
        if (allTags.contains(_tag)){
          showAlertDialog(
              context,
              title: 'Essa Tag já é utilizada',
              content: 'Escolha uma Tag diferente',
              defaultActionText: 'OK'
          );
        } else{
          final dispositivo = Dispositivo(tipo: _tipo, comodo: _comodo, tag: _tag);
          await widget.database.createDispositivo(dispositivo);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(
            context,
            title: 'Algo deu errado ao criar o dispositivo',
            exception: e,
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextColor.withOpacity(0.2),
      body: AlertDialog(
        scrollable: true,
        backgroundColor: Colors.black87,
        insetPadding: EdgeInsets.all(32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(36)),
        ),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Center(
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 40,
                    color: kTextColor.withOpacity(0.2),
                  ),
                ]),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildFormChildren(),
                  ),
                ),
              ),
            );
          },
        ),
        //title:
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      SizedBox(height: 20),
      Text(
        'Novo Dispositivo',
        style: Theme.of(context).textTheme.headline4.copyWith(
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 35,),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Qual o tipo?',
          style: Theme.of(context).textTheme.headline6.copyWith(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 20),
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tipoDispositivo').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Text('Carregando');
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
            return DropdownButtonFormField(
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
              onSaved: (value) => _tipo = value,
            );
          }
        },
      ),
      SizedBox(height: 35),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Onde?',
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      SizedBox(height: 20),
      StreamBuilder<QuerySnapshot>(
       stream: FirebaseFirestore.instance.collection('comodoDispositivo').snapshots(),
        builder: (context, snapshot){
        if(!snapshot.hasData){
          return Text('Carregando' );
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
            return DropdownButtonFormField(
              iconSize: 40,
              dropdownColor: Colors.grey[800],
              isExpanded: true,
              items: dispositivoItems,
              onChanged: (dispositivoComodo){
              setState(() {
              selectedComodo = dispositivoComodo;
               });
              },
              value: selectedComodo,
              onSaved: (value) => _comodo = value,
            );
          }
        },
      ),
      SizedBox(height: 35),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Tag',
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      TextFormField(
        style: Theme.of(context).textTheme.headline5.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          hintText: 'i.e. Lâmpada 1 | Cortina da Sala | etc',
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        onSaved: (value) => _tag = value,
        validator: (value) => value.isNotEmpty ? null : 'Defina a tag.',
      ),
      SizedBox(height: 40),
      MaterialButton(
        shape: CircleBorder(),
        color: kPrimaryColor,
        elevation: 0,
        onPressed: _enviarDispositivo,
        child: Icon(
          Icons.add,
          size: 20.0,
          color: Colors.black,
        ),
      ),

      Text(
        'Adicionar',
        style: TextStyle(fontSize: 15, color: kPrimaryColor),
      ),
    ];
  }
}
