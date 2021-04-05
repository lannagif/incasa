import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incasa/app/components/macMask.dart';
import 'package:incasa/app/components/show_alert_dialog.dart';
import 'package:incasa/app/components/show_exception_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:incasa/app/components/const.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';
import 'package:incasa/app/services/database.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddDisp extends StatefulWidget {

  const AddDisp({Key key, @required this.database,this.dispositivo}) : super(key: key);
  final Database database;
  final Dispositivo dispositivo;

  static Future<void> show(BuildContext context, {Dispositivo dispositivo}) async {
    // context of dispositivos page
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryanimation) => AddDisp(database: database, dispositivo: dispositivo,),
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
  String _mac;
  int _estado=0;

  var selectedDispositivo;
  var selectedComodo;

  final _macMask = TextEditingController();
  bool _ok = false;
  //var controller = MaskTextInputFormatter(mask: 'xx.xx.xx.xx.xx.xx');


  @override
  void initState(){
    super.initState();
    if(widget.dispositivo != null){
      _tipo = widget.dispositivo.tipo;
      _comodo = widget.dispositivo.comodo;
      _tag = widget.dispositivo.tag;
      _mac = widget.dispositivo.mac;
      _estado = widget.dispositivo.estado;
    }
  }


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
        /*RegExp validaMac = RegExp('^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})\$');
        Iterable<Match> matches = validaMac.allMatches(_macMask.text);
        setState(() {
          if(matches.length == 0){
            _ok = false;
          } else {
            _ok = true;
          }
        });*/
        final dispositivos = await widget.database.dispositivoStream().first;
        final allTags = dispositivos.map((dispositivo) => dispositivo.tag).toList();
        if(widget.dispositivo != null){
          allTags.remove(widget.dispositivo.tag);
        }
        if (allTags.contains(_tag)){
          showAlertDialog(
              context,
              title: 'Essa Tag já é utilizada',
              content: 'Escolha uma Tag diferente',
              defaultActionText: 'OK'
          );
        } else{
          final id = widget.dispositivo?.id ?? documentIDFromCurrentDate();
          final dispositivo = Dispositivo(id: id, tipo: _tipo, comodo: _comodo, tag: _tag, mac: _mac, estado: _estado);
          await widget.database.setDispositivo(dispositivo);
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

  Future<void> _deleteDispositivo(Dispositivo dispositivo) async {

    try {
      final database = widget.database;
      await database.deleteDispositivo(dispositivo);
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
          context,
          title: 'Erro ao deletar dispositivo',
          exception: e,
      );
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
      Text(widget.dispositivo == null ? 'Novo dispositivo' : 'Editar dispositivo',
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
              value: widget.dispositivo == null ? selectedDispositivo :_tipo,
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
              value: widget.dispositivo == null ? selectedComodo : _comodo,
              onSaved: (value) => _comodo = value,
            );
          }
        },
      ),
      SizedBox(height: 35),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Endereço Mac do Dispositivo',
          style: Theme.of(context).textTheme.headline6.copyWith(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

        TextFormField(
          //controller: _macMask,
          // inputFormatters: <TextInputFormatter>[
          //   LengthLimitingTextInputFormatter(12),
          //   FilteringTextInputFormatter.allow(RegExp('^([0-9A-Fa-f]{2}[:]){5}([0-9A-Fa-f]{2})\$')),
          // ],
          style: Theme.of(context).textTheme.headline5.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(
            //hintText: 'i.e. xx:xx:xx:xx:xx',
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          initialValue: _mac,
          onSaved: (value) => _mac = value,
          validator: (value) => value.isNotEmpty ? null : 'Endereço mac é necessário.',
        ),

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
          hintText: 'Lâmpada 1 | Cortina da Sala | etc',
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        initialValue: _tag,
        onSaved: (value) => _tag = value,
        validator: (value) => value.isNotEmpty ? null : 'Defina a tag.',
      ),
      SizedBox(height: 40),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              MaterialButton(
                shape: CircleBorder(),
                color: kPrimaryColor,
                elevation: 0,
                onPressed: _enviarDispositivo,
                child: Icon(
                  widget. dispositivo == null ? Icons.add : Icons.system_update_alt,
                  size: 20.0,
                  color: Colors.black,
                ),
              ),
              Text(widget.dispositivo == null ? 'Adicionar' : 'Salvar',
                style: TextStyle(fontSize: 15, color: kPrimaryColor),
              ),
            ],
          ),
          widget.dispositivo == null ? Container() : _delete(widget.dispositivo),
        ],
      ),
    ];
  }

  Widget _delete(Dispositivo dispositivo){
    return Container(
      child: Column(
        children: [
          MaterialButton(
            shape: CircleBorder(),
            color: kPrimaryColor,
            elevation: 0,
            onPressed: () => _deleteDispositivo(dispositivo),
            child: Icon(
              Icons.delete_forever,
              size: 20.0,
              color: Colors.black,
            ),
          ),
          Text('Excluir',
            style: TextStyle(fontSize: 15, color: kPrimaryColor),
          ),
        ],
      ),
    );
  }



}
