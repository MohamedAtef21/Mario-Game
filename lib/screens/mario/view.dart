import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mario/screens/buttons/view.dart';
import 'package:mario/screens/mariomove/view.dart';
import 'package:mario/screens/mushroom/view.dart';
import '../jump/view.dart';

class MarioView extends StatefulWidget {
  const MarioView({Key? key}) : super(key: key);

  @override
  State<MarioView> createState() => _MarioViewState();
}

class _MarioViewState extends State<MarioView> {
  static double marioX = 0;
  static double marioY = 1;
  double marioSize = 50;
  double mushroomX = Random().nextDouble() * 2 - 1;
  double mushroomY = 1;
  double time = 0;
  double height = 0;
  double intiaHeight = marioY;
  String direction = "right";
  bool midrun = false;
  bool midjump = false;

  void atemushroom() {
    if ((marioX - mushroomX).abs() < 0.05 &&
        (marioY - mushroomY).abs() < 0.05) {
      setState(() {
        mushroomX = 2;
        if (!marioAteMushroom) {
          // marioSize = 70;
          score += 100; // increase score when mushroom is eaten
          marioAteMushroom = true; // set flag to indicate mushroom is eaten
        }
      });
    }
    if (mushroomX < -1 || mushroomX > 1 || mushroomY < 0) {
      setState(() {
        mushroomX = Random().nextDouble() * 2 - 1;
        mushroomY = 1;
        marioAteMushroom = false; // reset flag when new mushroom appears
      });
    }
  }

  void preJump() {
    time = 0;
    intiaHeight = marioY;
  }

  void jump() {
    //if statement to disable the double jump
    if (midjump == false) {
      midjump = true;
      preJump();
      Timer.periodic(const Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (intiaHeight - height > 1) {
          midjump = false;
          setState(() {
            marioY = 1;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = intiaHeight - height;
          });
        }
      });
    }
  }

  @override
  void initState() {
    mushroomX = Random().nextDouble() * 2 - 1;
    mushroomY = 1;
  }

  void moveRight() {
    direction = "right";
    atemushroom();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      atemushroom();
      if (const MarioButtonView().userIsHoldingButtonDown() == true &&
          (marioX + 0.02) < 1) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
          atemushroom();
        });
      }
    });
  }

  void moveLeft() {
    direction = "left";
    atemushroom();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      atemushroom();
      if (const MarioButtonView().userIsHoldingButtonDown() == true &&
          (marioX - 0.02) > -1) {
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
          atemushroom();
        });
      }
    });
  }

  int score = 0;
  bool marioAteMushroom = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  color: Colors.blue,
                  child: AnimatedContainer(
                    alignment: Alignment(marioX, marioY),
                    duration: const Duration(microseconds: 0),
                    child: midjump
                        ? JumpView(
                            direction: direction,
                            size: marioSize,
                          )
                        : MyMarioView(
                            direction: direction,
                            midrun: midrun,
                            size: marioSize,
                          ),
                  ),
                ),
                Container(
                  alignment: Alignment(mushroomX, mushroomY),
                  child: const MushroomView(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "MARIO",
                            style: GoogleFonts.gothicA1(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "00",
                            style: GoogleFonts.gothicA1(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "SCORE",
                            style: GoogleFonts.gothicA1(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "$score",
                            style: GoogleFonts.gothicA1(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "TIME",
                            style: GoogleFonts.gothicA1(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "9999",
                            style: GoogleFonts.gothicA1(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 10,
            color: Colors.green,
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MarioButtonView(
                    function: moveLeft,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  MarioButtonView(
                    function: jump,
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                  ),
                  MarioButtonView(
                    function: moveRight,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
