import 'package:flutter/material.dart';
import 'package:mario/screens/mario/view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageView(
        children: [
          MarioView(),
        ],
      ),
    );
  }
}
