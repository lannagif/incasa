import 'package:flutter/material.dart';
import 'package:incasa/app/components/const.dart';

class ThisBottomNavBar extends StatelessWidget {
  const ThisBottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: kDefPadding*6, right: kDefPadding*6),
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.black54,
        boxShadow: [
          BoxShadow(
            offset: Offset(0,-10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.dashboard,
              color: kPrimaryColor,
              size: 30,
            ),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(
              Icons.devices_other,
              color: kPrimaryColor,
              size: 30,
            ),
            onPressed: (){
              print('clicou');
            },
          ),
        ],
      ),
    );
  }
}

/*
AppBar buildAppBar(){
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(
        color: kPrimaryColor
    ),
  );
}
*/