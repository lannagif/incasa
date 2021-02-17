import 'dart:ui';
import 'package:meta/meta.dart';

class Dispositivo{


  Dispositivo({@required this.tipo, @required this.comodo});
  //Dispositivo({@required this.id, this.tipo, this.comodo, this.tag, this.estado});

  //final String id;
  final String tipo;
  final String comodo;
 // final String tag;
  //final bool estado;



  factory Dispositivo.fromMap(Map<String, dynamic> data){
    if(data == null){
      return null;
    }
    final String tipo = data['tipo'];
    final String comodo = data['comodo'];
    return Dispositivo(
        tipo: tipo,
        comodo: comodo
    );
    //return Dispositivo(id: documentID, tipo: tipo, comodo: comodo, tag: tag, estado: estado);
  }

  Map<String, dynamic> toMap() {
    return {
      //print('Teste')
      'tipo': tipo,
      'comodo': comodo,
      //'tag': tag,
      //'estado': estado,
    };
  }
}



