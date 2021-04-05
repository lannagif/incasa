import 'package:flutter/foundation.dart';

class EstadoDispositivo extends ChangeNotifier {

  int _estado = 0;

  int get estado => _estado;

  set estado(int value) {
    _estado = value;
    notifyListeners();
  }
}