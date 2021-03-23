import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeaderInfo with ChangeNotifier{

  String _nameUser = "morador(a)";
  //Icon _icon;

  String get nameUser => _nameUser;

  set nameUser(String name) {
    _nameUser = name;
    notifyListeners();
  }

  List<String> _dispositivos = [];

  List<String> get dispositivos {
    return [..._dispositivos];
  }
  set adicionarDispositivos(String element){
    _dispositivos.add(element);
    notifyListeners();
  }

  void salvarUserName(String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName);
  }

  Future<void> lerUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('userName');
    if(name == null) name = 'morador(a)';
    nameUser = name;
  }

}