import 'package:flutter/material.dart';
import 'package:incasa/app/components/const.dart';
import 'package:incasa/app/components/text_field.dart';


class AccountPg extends StatelessWidget {

  AccountPg({
    Key key,
    this.size,
    //@required this.page
  }) : super(key: key);

  //final Size size;
  //final int page;

  var size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Material(

      type: MaterialType.transparency,
      child: Hero(
        tag: 'accountPg',
        child: SafeArea(
          child: Container(
            // Ocupa 100% da tela
            height: size.height,
            width: size.width,
            color: kBackgroundColor,

            child: Stack(
              children: <Widget>[
                SizedBox(height: kDefPadding),
                Container(
                  height: size.height*0.92,
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

