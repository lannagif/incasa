import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:incasa/app/components/const.dart';
import 'package:incasa/app/servicos/autenticacao.dart';
import 'package:incasa/app/telas/account_pg.dart';
//import 'package:incasa/app/components/text_field.dart';



class HeaderToAccount extends StatefulWidget {
  const HeaderToAccount({
    Key key,
    @required this.size,
    @required this.page
  }) : super(key: key);

  final Size size;
  final int page;

  @override
  _HeaderToAccountState createState() => _HeaderToAccountState();
}

class _HeaderToAccountState extends State<HeaderToAccount> {
  Widget build(BuildContext context) {

    BorderRadiusGeometry radius = BorderRadius.only(
      bottomLeft: Radius.circular(36),
      bottomRight: Radius.circular(36),
    );


    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: ClipRRect(
          borderRadius: radius,
          child: Container(

            child: Stack(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            //fit: FlexFit.loose,
                            child: Container(
                              //margin: EdgeInsets.symmetric(vertical: kDefPadding),
                              child: MaterialButton(
                                child: Icon(
                                  Icons.tag_faces,
                                  size: 50.0,
                              ),
                                onPressed: (){

                                  /*
                                  Navigator.of(context).push(
                                    //MaterialPageRoute(builder: (context) => AccountPg(size: MediaQuery.of(context).size)),
                                    PageRouteBuilder(
                                      transitionDuration: Duration(milliseconds: 500),
                                      pageBuilder: (
                                          BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation) {
                                        return AccountPg(auth: Auth(),);
                                      },
                                      transitionsBuilder: (
                                          BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          Widget child) {
                                        return Align(
                                          child: FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          ),
                                        );
                                      },
                                    ),
                                  );*/
                                },
                                //shape: CircleBorder(),
                              ),
                            ),
                          ),
                          //SizedBox(width: 2.0,),
                          Expanded(
                            flex: 4,
                            child: Container(
                              //margin: EdgeInsets.only(left: kDefPadding),
                              child: Text(
                                'Olá, ',
                                style: Theme.of(context).textTheme.headline5.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          //Spacer(),
                          Expanded(
                            flex: 2,
                              child: buildBullets(widget.page),
                          ),
                        ],
                      ),
                      //Spacer(),
                    ],
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

Widget buildBullets(int page){
  return Material(
    color: kPrimaryColor,
    child: Padding(
      padding: EdgeInsets.only(left: kDefPadding*2, right: kDefPadding*2, top: kDefPadding/2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: 10,
            child: InkWell(
              onTap: (){},
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: page == 0 ? kTextColor : Colors.yellow[100],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: Container(
            width: 10,
            height: 10,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
                color: page == 1 ? kTextColor : Colors.yellow[100],
              ),
            ),
          ),
        ],

      ),
    ),
  );
}
