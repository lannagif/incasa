import 'package:flutter/material.dart';
import 'package:incasa/app/components/HomePgProvider/home_pg_provider.dart';
import 'package:incasa/app/components/speech/voice_pg.dart';
import 'package:incasa/app/components/header_info.dart';
import 'package:incasa/app/telas/body_dispositivos/body_dispositivo.dart';
import 'package:incasa/app/components/header.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:incasa/app/telas/account_pg.dart';

class HomePg extends StatefulWidget {


  @override
  _HomePgState createState() => _HomePgState();
}

class _HomePgState extends State<HomePg> {

  double _panelHeightOpen;

  //int _index = 0;

  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Provider.of<HeaderInfo>(context, listen: false).lerUserName();
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height*0.95;

    BorderRadiusGeometry radius = BorderRadius.only(
    bottomLeft: Radius.circular(36),
    bottomRight: Radius.circular(36),
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SlidingUpPanel(
          slideDirection: SlideDirection.DOWN,
          borderRadius: radius,
          maxHeight: _panelHeightOpen,
          collapsed:  HeaderToAccount(size: MediaQuery.of(context).size, page: Provider.of<HomePgProvider>(context).index),
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
                    currentIndex == 1 ? VoiceMode() : BodyDispositivos();
                  },
                    onPageChanged: (indexPage) {
                      this.setState(() {
                        // index = indexPage;
                        Provider.of<HomePgProvider>(context, listen: false).index = indexPage;
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
  Widget panel({@required ScrollController sc,}) => GestureDetector(
      onTap: () {
        if(!focusNode.hasPrimaryFocus) {
          focusNode.unfocus();
        }
      },
      child: AccountPg(sc: sc,));
}



