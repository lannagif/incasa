import 'dart:async';
//import 'dart:ffi';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:incasa/app/components/const.dart';
import 'package:incasa/app/telas/wifi_config/wifi_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:incasa/app/telas/wifi_config/wifi_info_esp.dart';
import 'package:provider/provider.dart';
//import 'package:incasa/app/services/database.dart';


class WifiInform extends StatefulWidget{


  @override
  _WifiInformState createState() => _WifiInformState();
}

class _WifiInformState extends State<WifiInform> {

  final _formKey = GlobalKey<FormState>();

  BorderRadiusGeometry radius = BorderRadius.only(
    bottomLeft: Radius.circular(36),
    bottomRight: Radius.circular(36),
  );

  String _connectionStatus = 'Desconhecido';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String wifi;
  String pwd;
  String a = 'teste 2';

  bool _isWifiInGatway = false;
  String ssid;
  String password;

  //final _wifiController = TextEditingController();


  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionStatus);

  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    if (Platform.isAndroid) {
      print('Verificando permissões do Android');
      var status = await Permission.location.status;
      // Blocked?
      if (status.isUndetermined || status.isDenied || status.isRestricted) {
        // Ask the user to unblock
        if (await Permission.location
            .request()
            .isGranted) {
          // Either the permission was already granted before or the user just granted it.
          print('Permissão de Localização concedida');
        } else {
          print('Permissão de Localização negada');
        }
      } else {
        print('Permissão de Localização previamente concedida');
      }
    }
    return updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          elevation: 0,
          /*title: Text(
            'Configurações de Rede',
            style: Theme
                .of(context)
                .textTheme
                .headline5
                .copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),*/
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        'Você está conectado no Wifi:',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5
                            .copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 1),
                              blurRadius: 38,
                            )
                          ]),
                      child: Center(
                        child: Text(
                          '$wifi',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline6
                              .copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    'Para realizar o pareamento\n das redes, insira a senha\n da sua rede Wifi.',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6
                        .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                flex: 1,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5
                            .copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(width: 1,color: kPrimaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(width: 1,color: kPrimaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(width: 1,color: kPrimaryColor),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            borderSide: BorderSide(width: 1,color: kPrimaryColor),
                          ),
                          //hintText: 'Senha da rede local',
                          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        onSaved: (value) => Provider.of<WifiInfoSsidPwd>(context, listen: false).pwd = value,//(value) => pwd = value,
                        //validator: (value) => value.isNotEmpty ? null : 'Insira a senha da rede local.',
                      ),
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 20),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: RaisedButton(
                        color: Colors.black,
                        //textColor: kPrimaryColor,
                        child: Icon(Icons.arrow_forward,
                        color: kPrimaryColor,),
                        onPressed: () =>
                          valor(),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    print('Result: $result');
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID;//, wifiIP;
        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
            await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
              await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } on PlatformException catch (e) {
          print('Error: $e.toString()');
          wifiName = "Failed to get Wifi Name";
        }
        print('Wi-Fi Name: $wifiName');

        try {
          if (Platform.isIOS) {
            LocationAuthorizationStatus status =
            await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
              await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }
        print('BSSID: $wifiBSSID');

        /*try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }*/

        setState(() {
          wifi = wifiName;
          Provider.of<WifiInfoSsidPwd>(context, listen: false).ssid = wifi;
          //print('$wifiName');
        });

        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Falha na conexão.');
        break;
    }
  }

  valor(){
    _formKey.currentState.save();
    print(Provider.of<WifiInfoSsidPwd>(context, listen: false).pwd);
    print(Provider.of<WifiInfoSsidPwd>(context, listen: false).ssid);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WifiInformEsp()),
    );
  }


/*
  String get wifi => _wifi;

  set wifi(String ssid) {
    _wifi = ssid;
    //notifyListeners();
  }*/
}
