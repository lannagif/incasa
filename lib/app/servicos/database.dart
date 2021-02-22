import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';
import 'package:meta/meta.dart';
import 'package:incasa/app/servicos/api_path.dart';
import 'package:incasa/app/servicos/firestore_service.dart';
//import 'package:flutter/material.dart';

abstract class Database{

  Future<void> setDispositivo(Dispositivo dispositivo); // Método Create and Update = setDispositivo
  Future<void> deleteDispositivo(Dispositivo dispositivo);
  Stream<List<Dispositivo>> dispositivoStream();

  //Stream<List<Dispositivo>> streamDispositivo();
  //Stream<Dispositivo> streamDispositivo({@required String dispositivoID});

}

String documentIDFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database{

  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setDispositivo(Dispositivo dispositivo) => _service.setData(
    path: APIPath.dispositivo(uid, dispositivo.id),
    data: dispositivo.toMap(),
  );

  @override
  Future<void> deleteDispositivo(Dispositivo dispositivo) => _service.deleteData(
      path: APIPath.dispositivo(uid, dispositivo.id),
  );

  @override
  Stream<List<Dispositivo>> dispositivoStream() => _service.collectionStream(
    path: APIPath.dispositivos(uid),
    builder: (data, documentID) => Dispositivo.fromMap(data, documentID),
  );


  /*
  @override
  Future<void> setDispositivo(Dispositivo dispositivo) => _service.setData(
    path: APIPath.dispositivo(uid, dispositivo.id),
    data: dispositivo.toMap(),
  );
  */




}
