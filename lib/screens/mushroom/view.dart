import 'package:flutter/material.dart';

class MushroomView extends StatelessWidget {
  const MushroomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      child: Image.asset("assets/images/mushroom.png"),
    );
  }
}
