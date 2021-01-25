import 'package:flutter/material.dart';
import 'package:incasa/app/components/const.dart';


class DispositivoCards extends StatelessWidget {
  const DispositivoCards({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DispositivoCard(
          image: 'assets/imgs/lamp.png',
          nomedispositivo: 'Lâmpada',
          textdispositivo: 'dispositivo',
          qtddispositivo: 1,
        ),
      ],
    );
  }
}

class DispositivoCard extends StatelessWidget {
  const DispositivoCard({
    Key key,
    this.image,
    this.nomedispositivo,
    this.textdispositivo,
    this.qtddispositivo,
    this.press,
  }) : super(key: key);

  final String image, nomedispositivo, textdispositivo;
  final int qtddispositivo;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(kDefPadding),
        child: Container(
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(36)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0,10),
                  blurRadius: 40,
                  color: kTextColor.withOpacity(0.2),
                ),
              ]
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(kDefPadding/2),
                  child: Image.asset(image),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: kDefPadding),
                  child: Container(
                    //width: size.width*0.5,
                    height: size.height*0.25,
                    child: Center(
                      child: Column(
                        children: [
                          Spacer(),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '$nomedispositivo\n'.toUpperCase(),
                                      style: Theme.of(context).textTheme.headline5.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '$qtddispositivo $textdispositivo',
                                      style: Theme.of(context).textTheme.headline6.copyWith(
                                        color: Colors.black.withOpacity(0.5),
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        print('clicou');
      },
    );
  }
}