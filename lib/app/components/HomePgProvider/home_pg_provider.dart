import 'package:flutter/foundation.dart';

class HomePgProvider with ChangeNotifier{

  int _index = 0;

  int get index => _index;

  set index(int value) {
    _index = value;
    notifyListeners();
  }

  /*
  List<String> _dispositivos = [];

  List<String> get dispositivos {
    return [..._dispositivos];
  }
  set adicionarDispositivos(String element){
    _dispositivos.add(element);
    notifyListeners();
  }
  */

}