import 'package:flutter/material.dart';
import 'package:incasa/app/components/dispositivos/card_dispositivo.dart';
import 'package:incasa/app/components/dispositivos/dispositivo_cards.dart';
import 'package:incasa/app/components/title_with_add_button.dart';
import 'package:incasa/app/telas/novo_dispositivo_pg.dart';
import 'package:incasa/app/servicos/database.dart';
import 'package:provider/provider.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';



class BodyDispositivos extends StatelessWidget {

  //final _pageControler = PageController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SizedBox(height: 120),
          TitleWithAdd(text: 'Dispositivos'), //, press: (){},),
          SizedBox(height: 50),
          //DispositivoCards(),
          _buildContents(context),
        ],
      ),
    );
  }


    Widget _buildContents(BuildContext context) {
      final database = Provider.of<Database>(context, listen: false);
      return StreamBuilder<List<Dispositivo>>(
        stream: database.dispositivoStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final dispositivos = snapshot.data;
            final children = dispositivos.map((dispositivo) => CardDispositivo(
                dispositivo: dispositivo,
                onTap: (){},)).toList();
            //TODO: Substituir por cards
            return ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: children,
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred'));
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    }



}




