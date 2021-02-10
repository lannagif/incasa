import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:incasa/app/components/const.dart';

class ListItemTipo{
  int value;
  String name;

  ListItemTipo(this.value, this.name);
}

class ListItemComodo{
  int value;
  String name;

  ListItemComodo(this.value, this.name);
}

class AddDisp extends StatefulWidget {

  @override
  _AddDispState createState() => _AddDispState();
}

class _AddDispState extends State<AddDisp> {

  // Menu para Dispositivos
  static const String Tipo1 = 'Lâmpada';
  static const String Tipo2 = 'Cortina';

  List<ListItemTipo> _tiposDispositivos = [
    ListItemTipo(1, Tipo1),
    ListItemTipo(2, Tipo2),
  ];

  List<DropdownMenuItem<ListItemTipo>> _dropDownMenuItems;
  ListItemTipo _selectedItem;

  // Menu para Comodos
  static const String Comodo1 = 'Quarto';
  static const String Comodo2 = 'Sala';
  static const String Comodo3 = 'Garagem';
  static const String Comodo4 = 'Cozinha';

  List<ListItemComodo> _comodos = [
    ListItemComodo(1, Comodo1),
    ListItemComodo(2, Comodo2),
    ListItemComodo(3, Comodo3),
    ListItemComodo(4, Comodo4),
  ];

  List<DropdownMenuItem<ListItemComodo>> _dropDownMenuItemsComodo;
  ListItemComodo _selectedItemComodo;

  void initState(){
    _dropDownMenuItems = buildDropDownMenuItems(_tiposDispositivos);
    _selectedItem = _dropDownMenuItems[0].value;

    _dropDownMenuItemsComodo = buildDropDownMenuItemsComodo(_comodos);
    _selectedItemComodo = _dropDownMenuItemsComodo[0].value;
    super.initState();
  }

  List<DropdownMenuItem<ListItemTipo>>buildDropDownMenuItems(List listItems){
    List<DropdownMenuItem<ListItemTipo>> items = List();
    for (ListItemTipo listItem in listItems){
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }


  List<DropdownMenuItem<ListItemComodo>>buildDropDownMenuItemsComodo(List listItems){
    List<DropdownMenuItem<ListItemComodo>> items = List();
    for (ListItemComodo listItemComodo in listItems){
      items.add(
        DropdownMenuItem(
          child: Text(listItemComodo.name),
          value: listItemComodo,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      color: kTextColor,
      elevation: 0,
      child: Icon(
        Icons.add,
        size: 20.0,
        color: kPrimaryColor,
      ),
      onPressed: (){
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                scrollable: true,
                backgroundColor: Colors.black87,
                insetPadding: EdgeInsets.all(32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(36)),),
                content: Center(
                  child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                      //color: kPrimaryColor,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0,10),
                            blurRadius: 40,
                            color: kTextColor.withOpacity(0.2),
                          ),
                        ]
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20),
                        Text('Novo Dispositivo',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 35,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Qual o tipo?',
                            style: Theme.of(context).textTheme.headline6.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<ListItemTipo>(
                              style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              iconSize: 40,
                              dropdownColor: Colors.grey[800],
                              isExpanded: true,
                              value: _selectedItem,
                              items: _dropDownMenuItems,
                              onChanged:(newValue){
                                if(mounted) {
                                  setState(() {
                                    _selectedItem = newValue;
                                  });
                                  print(_selectedItem);
                                }
                              }),
                        ),
                        SizedBox(height: 35),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Onde?',
                            style: Theme.of(context).textTheme.headline6.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),),
                        ),
                        SizedBox(height: 20),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<ListItemComodo>(
                              style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              iconSize: 40,
                              dropdownColor: Colors.grey[800],
                              isExpanded: true,
                              value: _selectedItemComodo,
                              items: _dropDownMenuItemsComodo,
                              onChanged: (value){
                                if(mounted) {
                                  setState(() {
                                    _selectedItemComodo = value;
                                  });
                                  print(_selectedItemComodo);
                                }
                              }),
                        ),
                        SizedBox(height: 35),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Tag',
                            style: Theme.of(context).textTheme.headline6.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),),
                        ),
                        TextFormField(
                          style:  Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          //TextStyle(fontSize: 20, color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'i.e. Lâmpada 1 | Cortina da Sala | etc',
                            hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(

                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor,
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.all(5),
                                child: Icon(Icons.add, color: Colors.black,),
                              ),
                              Text('Adicionar',
                                style: TextStyle(fontSize: 15, color: Colors.black),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //title:
              );
            });
      },
      shape: CircleBorder(),
    );
  }
}

/*
addTipo{
  return StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('dispositivo').snapshots(),
  builder: (context, snapshot){
    if(!snapshot.hasData){

      }
    },
  );
}
 */