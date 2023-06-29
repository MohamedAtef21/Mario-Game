import 'dart:math';

import 'package:flutter/material.dart';

class MyMarioView extends StatelessWidget {

  final direction;
  final midrun;
  final size;

  MyMarioView({this.direction, this.midrun, this.size});


  @override
  Widget build(BuildContext context) {
    if (direction == "right"){
      return Container(
        width: size,
        height: size,
        child: midrun ? Image.asset("assets/images/mario_stand.png"):
        Image.asset("assets/images/mario_run.png"),
      );
    }else{
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: size,
          height: size,
          child: midrun ? Image.asset("assets/images/mario_stand.png"):
          Image.asset("assets/images/mario_run.png"),
        ),
      );
    }
  }
}
