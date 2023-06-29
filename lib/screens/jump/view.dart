import 'dart:math';

import 'package:flutter/material.dart';

class JumpView extends StatelessWidget {

  final direction;
  final size;

  JumpView({this.direction,this.size});

  @override
  Widget build(BuildContext context) {
    if (direction == "right"){
      return Container(
        width: size,
        height: size,
        child: Image.asset("assets/images/mario_jump.png"),
      );
    }else{
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: size,
          height: size,
          child: Image.asset("assets/images/mario_jump.png"),
        ),
      );
    }
  }
}
