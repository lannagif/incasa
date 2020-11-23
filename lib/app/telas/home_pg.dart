import 'package:flutter/material.dart';
import 'package:incasa/app/components/body.dart';
import 'package:incasa/app/components/const.dart';
import 'package:incasa/app/components/this_bottom_nav_bar.dart';
import 'package:incasa/app/components/header.dart';

class HomePg extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
          child: Column(

            children: [

              HeaderToAccount(size: MediaQuery.of(context).size),
              Expanded(
                child: PageView.builder(
                  itemCount: 2,
                  itemBuilder: (_, currentIndex){
                    return Body();
                  },
              ),
              ),
            ],
          ),
      ),
    );
  }
}



