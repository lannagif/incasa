import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:incasa/app/components/comodos/body_comodos.dart';
import 'package:incasa/app/telas/body_dispositivos/body_dispositivo.dart';
import 'package:incasa/app/components/header.dart';
import 'package:incasa/app/servicos/autenticacao.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../telas/account_pg.dart';

class HomePg extends StatefulWidget {

  HomePg({Key key, @required this.auth}) : super(key: key);
  final BaseAutenticacao auth;


  @override
  _HomePgState createState() => _HomePgState();
}

class _HomePgState extends State<HomePg> {

  double _panelHeightOpen;

  int index = 0;

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height*0.95;

    BorderRadiusGeometry radius = BorderRadius.only(
    bottomLeft: Radius.circular(36),
    bottomRight: Radius.circular(36),
    );

    return SafeArea(
      child: Scaffold(

        body: SlidingUpPanel(
          slideDirection: SlideDirection.DOWN,
          borderRadius: radius,
          maxHeight: _panelHeightOpen,
          collapsed:  HeaderToAccount(size: MediaQuery.of(context).size, page: index),
          panelBuilder: (sc) => panel(
            sc: sc,
          ),

          body: Column(
            children: [

              Expanded(
                child: PageView.builder(
                  itemCount: 2,
                  itemBuilder: (_, currentIndex){
                    return
                    currentIndex == 1 ? BodyComodos() : BodyDispositivos();
                  },
                    onPageChanged: (indexPage) {
                      this.setState(() {
                        index = indexPage;
                      });
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget panel({@required ScrollController sc,}) => AccountPg(auth: null, sc: sc,);
}



