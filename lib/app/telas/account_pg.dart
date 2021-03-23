
import 'package:incasa/app/components/header_info.dart';
import 'package:incasa/app/telas/wifi_config/wifi_info_pg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:incasa/app/components/const.dart';
import 'package:incasa/app/servicos/autenticacao.dart';
import 'package:incasa/app/telas/wifi_config/wifi_manager.dart';
//import 'package:incasa/app/servicos/database.dart';


class AccountPg extends StatefulWidget {

  AccountPg({
    Key key,

    @required this.sc
  }) : super(key: key);

  final ScrollController sc;

  @override
  _AccountPgState createState() => _AccountPgState();
}

class _AccountPgState extends State<AccountPg> {
  final focusNode = FocusNode();
  int index = 0;

  TextEditingController moradorController = TextEditingController()..text = 'morador(a)';

 Future<void> _signOut(BuildContext context) async {
   try {
     final auth = Provider.of<BaseAutenticacao>(context, listen: false);
     await auth.signOut();
   } catch (e) {
     print(e.toString());
   }
 }

  @override
  Widget build(BuildContext context) {

    //controller: sc,
    BorderRadiusGeometry radius = BorderRadius.only(
      bottomLeft: Radius.circular(36),
      bottomRight: Radius.circular(36),
    );

    return Material(
      color: Colors.transparent,
      type: MaterialType.transparency,
      child: SafeArea(
        child: ClipRRect(
          borderRadius: radius,
          child: Container(
            color: kPrimaryColor,
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: <Widget>[
                  //SizedBox(height: kDefPadding),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                //margin: EdgeInsets.symmetric(vertical: kDefPadding),
                                child: MaterialButton(
                                  child: Icon(
                                    Icons.tag_faces,
                                    size: 50.0,
                                  ),
                                  onPressed: () => VoidCallback,
                                  shape: CircleBorder(),
                                ),
                              ),
                              SizedBox(width: 2.0,),
                              Container(
                                //margin: EdgeInsets.only(left: kDefPadding),
                                child: Row(
                                  children: [
                                    Text(
                                      'Olá,', //+ Texto(),
                                      style: Theme.of(context).textTheme.headline5.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Container(
                                      width: 150,
                                      child: TextFormField(
                                        keyboardType: TextInputType.name,
                                        controller: moradorController,
                                        style: Theme.of(context).textTheme.headline5.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        //initialValue: 'morador(a)',

                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),

                                        validator: (moradorController) {
                                          if (moradorController.isEmpty){
                                            return Provider.of<HeaderInfo>(context).nameUser;
                                          }
                                          return null;
                                        },
                                        onFieldSubmitted: (text){
                                          Provider.of<HeaderInfo>(context, listen: false).nameUser = text;
                                          Provider.of<HeaderInfo>(context, listen: false).salvarUserName(text);
                                          focusNode.unfocus();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Texto(),
                            ],
                          ),
                          SizedBox(height: 50,),
                          Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Configurações de Rede',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    MaterialButton(
                                      color: kTextColor,
                                      elevation: 0,
                                      child: Icon(
                                        Icons.settings,
                                        size: 20.0,
                                        color: kPrimaryColor,
                                      ),
                                      shape: CircleBorder(),
                                      onPressed: () {Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => WifiManager(page: index)),
                                      );},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height:30,),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Modo voz',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    MaterialButton(
                                      color: kTextColor,
                                      elevation: 0,
                                      child: Icon(
                                        Icons.settings_voice_sharp,
                                        size: 20.0,
                                        color: kPrimaryColor,
                                      ),
                                      shape: CircleBorder(),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30,),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    //SizedBox(width: 25,),
                                    Text('Sair do InCasa',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    MaterialButton(
                                      color: kTextColor,
                                      elevation: 0,
                                      child: Icon(
                                        Icons.logout,
                                        size: 20.0,
                                        color: kPrimaryColor,
                                      ),
                                      shape: CircleBorder(),
                                      onPressed: () => _signOut(context),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          //buildBullets(page),
                          //Texto(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}

