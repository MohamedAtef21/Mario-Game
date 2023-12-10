import 'package:flutter/material.dart';

class MarioButtonView extends StatelessWidget {

  final child;
  final function;
  static bool holdingButton = false;
  const MarioButtonView({super.key, this.child, this.function});

  bool userIsHoldingButtonDown(){
    return holdingButton;
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTapDown: (details){
        holdingButton = true;
        function();
      },
      onTapUp: (details){
        holdingButton = false;
      },
      child: Container(
        padding: const EdgeInsets.all(10),
          color: Colors.brown[300],
          child: child,
      ),
    );
  }
}
