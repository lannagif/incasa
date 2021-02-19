import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:incasa/app/components/const.dart';
import 'package:incasa/app/servicos/autenticacao.dart';
import 'package:incasa/app/servicos/database.dart';


class AccountPg extends StatelessWidget {

  AccountPg({
    Key key,
    //this.size,
    //@required this.auth,
    @required this.sc
  }) : super(key: key);

  final ScrollController sc;
  //final BaseAutenticacao auth;

 Future<void> _signOut(BuildContext context) async {
   try {
     final auth = Provider.of<BaseAutenticacao>(context, listen: false);
     await auth.signOut();
     //onSignOut();
   } catch (e) {
     print(e.toString());
   }
 }


  //final Size size;
  //final int page;

  //var size;

  @override
  Widget build(BuildContext context) {
    //controller: sc,
    BorderRadiusGeometry radius = BorderRadius.only(
      bottomLeft: Radius.circular(36),
      bottomRight: Radius.circular(36),
    );
    //size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      type: MaterialType.transparency,
      child: SafeArea(
        child: ClipRRect(
          borderRadius: radius,
          child: Container(
            color: kPrimaryColor,
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
                              child: Text(
                                'Olá,',//+ Texto(),
                                style: Theme.of(context).textTheme.headline5.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
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
    );
  }
}

