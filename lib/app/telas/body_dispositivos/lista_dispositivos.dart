/*
import 'package:flutter/material.dart';
import 'package:incasa/app/telas/body_dispositivos/vazio.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({Key key, @required this.snapshot, @required this.itemBuilder}) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;


  @override
  Widget build(BuildContext context) {
    if(snapshot.hasData){
      final List<T> items = snapshot.data;
      if(items.isNotEmpty){
        return _buildList(items, context);
      }else{
        return Vazio();
      }
    }else if(snapshot.hasError){
      return Vazio(
        title: 'Algo deu errado',
        message: 'Não foi possível carregar os items',
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items, BuildContext context){
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => itemBuilder(context, items[index]),
        ),
      ),
    );
  }

}
*/
