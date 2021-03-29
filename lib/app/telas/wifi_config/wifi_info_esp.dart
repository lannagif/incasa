import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:incasa/app/telas/wifi_config/wifi_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:incasa/app/components/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:incasa/app/telas/wifi_config/wifi_info_pg.dart';
import 'package:incasa/app/services/database.dart';
import 'package:incasa/app/services/autentication.dart';
import 'package:firebase_auth/firebase_auth.dart';



class WifiInformEsp extends StatefulWidget {

  WifiInformEsp({this.wifi, this.pwd});

  final String wifi;
  final  String pwd;

  @override
  _WifiInformEspState createState() => _WifiInformEspState();
}

class _WifiInformEspState extends State<WifiInformEsp> {

  String uid;

      BorderRadiusGeometry radius = BorderRadius.only(
      bottomLeft: Radius.circular(36),
      bottomRight: Radius.circular(36),
    );

    String _connectionStatus = 'Desconhecido';
    final Connectivity _connectivity = Connectivity();
    StreamSubscription<ConnectivityResult> _connectivitySubscription;

    String wifi;
    bool _isWifiInGatway = false;
    String ssid;
    String password;


    @override
    void initState() {
      super.initState();
      initConnectivity();
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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
        print('Checking Android permissions');
        var status = await Permission.location.status;
        // Blocked?
        if (status.isUndetermined || status.isDenied || status.isRestricted) {
          // Ask the user to unblock
          if (await Permission.location.request().isGranted) {
            // Either the permission was already granted before or the user just granted it.
            print('Location permission granted');
          } else {
            print('Location permission not granted');
          }
        } else {
          print('Permission already granted (previous execution?)');
        }
      }
      return _updateConnectionStatus(result);
    }

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Configurações de Rede',
              style: Theme.of(context).textTheme.headline5.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                      child: Container(
                        child: Text(
                          'Conecte-se na rede:',
                          style: Theme.of(context).textTheme.headline5.copyWith(
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            color: Colors.yellow[100],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[700],
                                offset: Offset(0, 1),
                                blurRadius: 38,
                              )
                            ]),
                        child: Center(
                          child: Text(
                            'InGateway',
                            style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.black,
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
                  child: Container(
                    child: Text(
                      'Clique em OK quando estiver conectado em InGateway.',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: RaisedButton(
                    color: Colors.black,
                    //textColor: kPrimaryColor,
                    child: Text(
                      'Ok',
                      style: TextStyle(
                        fontSize: 20,
                        color: kPrimaryColor,
                      ),
                    ),
                    onPressed: () => _sendToEsp(),//=> MaterialPageRoute(builder: (context) => WifiInformEsp()),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      );
    }

    @override
    Future<void> _updateConnectionStatus(ConnectivityResult result) async {
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

          /*   try {
            wifiIP = await _connectivity.getWifiIP();
          } on PlatformException catch (e) {
            print(e.toString());
            wifiIP = "Failed to get Wifi IP";
          }*/

          setState(() {
            //_connectionStatus;
            wifi = wifiName;
            print('$wifiName');
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

    @override
    String getSsid()  {
        final ssid = Provider.of<WifiInfoSsidPwd>(context,listen: false).ssid;
        return ssid;
    }

  @override
  String getPwd() {
      final pwd = Provider.of<WifiInfoSsidPwd>(context, listen: false).pwd;
      return pwd;
  }

  @override
  String getUid() {
    final auth = Provider.of<AuthBase>(context, listen: false);
    print(auth.currentUser.uid);
    return auth.currentUser.uid;
  }

      @override
      _sendToEsp() async {
        var queryParameters = {
          'uid' : getUid(), //Baseautenticação
          'ssid': getSsid(), //rede local
          'pwd': getPwd(), //rede local
        };
        var uri = Uri.http('192.168.0.143', 'setup', queryParameters);

        var response = await http.get(uri
         /*   headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        }*/
        );

        if (response.statusCode == 200) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.

          return ;
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          throw Exception('Failed to load album');
        }
      }
}
