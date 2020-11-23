import 'package:flutter/material.dart';
import 'package:incasa/app/components/const.dart';

class HeaderToAccount extends StatelessWidget {
  const HeaderToAccount({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override

  Widget build(BuildContext context) {
    return Container(
      // Ocupa 10% da tela
      height: size.height*0.1,
      width: size.width,
      color: kBackgroundColor,

      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.12,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0,10),
                  blurRadius: 40,
                  color: kPrimaryColor.withOpacity(0.8),
                ),
              ],
            ),
          ),
          Positioned(
            child: Column(
              children: [
                Row(
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
                        'Olá, Anna!',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                _buildBullets(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildBullets(){
  return Padding(
    padding: EdgeInsets.only(left: kDefPadding*2, right: kDefPadding*2, top: kDefPadding/2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: kTextColor,
          ),
        ),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.yellow[100],
          ),
        ),
      ],
    ),
  );
}