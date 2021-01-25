import 'package:flutter/material.dart';
import 'package:incasa/app/components/body_comodos.dart';
import 'package:incasa/app/components/body_dispositivo.dart';
import 'package:incasa/app/components/header.dart';



class HomePg extends StatefulWidget {


  @override
  _HomePgState createState() => _HomePgState();
}

  class _HomePgState extends State<HomePg> {

    int index = 0;

    @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: buildAppBar(),
        body: Column(
          children: [
            HeaderToAccount(size: MediaQuery.of(context).size, page: index),
            Expanded(
              child: PageView.builder(
                itemCount: 2,
                itemBuilder: (_, currentIndex){
                  return
                  currentIndex == 1 ? BodyDispositivos() : BodyComodos();
                },
                  onPageChanged: (indexPage) {
                    this.setState(() {
                      index = indexPage;
                    });
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}



