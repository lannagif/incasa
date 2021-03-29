//import 'package:flutter/foundation.dart';
//import 'package:provider/provider.dart';

class WifiInfoSsidPwd {

  String _pwd = 'teste';

  set pwd(String value) {
    _pwd = value;
    print(value);
  }

  String get pwd => _pwd;

  String _ssid;

  String get ssid => _ssid;

  set ssid(String value) {
    _ssid = value;
    print(value);
  }
}