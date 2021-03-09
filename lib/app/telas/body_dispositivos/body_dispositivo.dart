import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:incasa/app/components/dispositivos/card_dispositivo.dart';
//import 'package:incasa/app/components/dispositivos/dispositivo_cards.dart';
import 'package:incasa/app/components/title_with_add_button.dart';
import 'package:incasa/app/modelos/tipo_dispositivo.dart';
//import 'package:incasa/app/telas/body_dispositivos/lista_dispositivos.dart';
import 'package:incasa/app/telas/body_dispositivos/vazio.dart';
//import 'package:incasa/app/telas/novo_dispositivo_pg.dart';
import 'package:incasa/app/servicos/database.dart';
import 'package:provider/provider.dart';
import 'package:incasa/app/modelos/dispositivo_modelo.dart';



class BodyDispositivos extends StatelessWidget {

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SizedBox(height: 120),
          TitleWithAdd(text: 'Dispositivos'), //, press: (){},),
          //SizedBox(height: 50),
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

        /*  return ListItemsBuilder<Dispositivo>(
            snapshot: snapshot,
            itemBuilder: (context, dispositivo) => CardDispositivo(
                dispositivo: dispositivo,
                onTap: () => AddDisp.show(context, dispositivo: dispositivo),
            ),
          );*/


          if (snapshot.hasData) {
            final dispositivos = snapshot.data;
            if(dispositivos.isNotEmpty) {
              final children = dispositivos.map((dispositivo) =>
                  Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actions: [
                      Container(
                        margin: EdgeInsets.fromLTRB(2, 40, 2, 40),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(36),
                          child: IconSlideAction(
                            icon: Icons.edit_outlined,
                            caption: 'Editar',
                            color: Colors.grey[300],
                            onTap: () => AddDisp.show(context, dispositivo: dispositivo,),
                          ),
                        ),
                      ),
                    ],
                    actionExtentRatio: 0.25,
                    child: CardDispositivo(
                      key: Key('dispositivo-${dispositivo.id}'),
                      dispositivo: dispositivo,
                      onTap: () =>
                          AddDisp.show(context, dispositivo: dispositivo),
                    ),
                  )).toList();

              return ListView(
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: children,
              );
            }
            return Vazio();
          }
          if (snapshot.hasError) {
            return Center(child: Text('Aconteceu algo inesperado'));
          }
          return Center(child: CircularProgressIndicator());

        },
      );
    }
}




