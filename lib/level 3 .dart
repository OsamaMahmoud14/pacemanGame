import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'Models/path.dart';
import 'Models/player.dart';
import 'constants/constants.dart';
import 'pacemanLevels.dart';




class level3 extends StatefulWidget {
  const level3({Key? key}) : super(key: key);

  @override
  State<level3> createState() => _level3State();
}

class _level3State extends State<level3> {
  Timer? timer;
  static const maxSeconds = 120;
  int seconds = maxSeconds;
  int player = numberInRow * 15 + 1;
  static int numberInRow = 11;
  int numberofSquares = numberInRow * 17;
  static List<int> barries = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    21,
    32,
    43,
    54,
    65,
    76,
    87,
    109,
    120,
    131,
    142,
    153,
    164,
    175,
    186,
    24,
    26,
    28,
    30,
    35,
    37,
    38,
    39,
    41,
    46,
    52,
    57,
    59,
    61,
    63,
    70,
    72,
    78,
    79,
    80,
    81,
    83,
    84,
    85,
    86,
    100,
    101,
    102,
    103,
    105,
    106,
    107,
    108,
    114,
    116,
    123,
    127,
    125,
    129,
    140,
    134,
    151,
    162,
    145,
    156,
    147,
    158,
    148,
    149,
    160,
    162,
    151
  ];

  List<int> foodList = [];
  String direction = 'right';
  bool mouthClosed = false;
  bool preGame = true;
  int score = 0;
  String ghostDirection = "left";

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  void moveGhost() {}
  void startGame() {
    if (score > 0 || score < 87) {
      setState(() {
        preGame = false;
        startTimer();
      });
      getFood();
    }

    Duration duration = const Duration(milliseconds: 350);
    Timer.periodic(duration, (timer) {
      if (score == 87) {
        setState(() async {
          await AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: 'مبروك ',
            desc: 'شاطر انت كسبت ',
            btnCancelOnPress: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) =>  pacemanLevels()));
            },
            btnOkOnPress: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const level3()));
            },
          ).show();
          score = 0;
          player = numberInRow * 15 + 1;
          getFood();
        });
      } else if (seconds == 0) {
        setState(() async {
          stopTimer();
          seconds = 0;
          await AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: 'معلش  ',
            desc: 'يلا نجرب تاني ',
            btnCancelOnPress: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => pacemanLevels()));
            },
            btnOkOnPress: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const level3()));
            },
          ).show();
        });
      }
      if (foodList.contains(player)) {
        foodList.remove(player);
        score++;
      }

      switch (direction) {
        case "left":
          moveLeft();
          break;
        case "right":
          moveRight();

          break;
        case "up":
          moveUp();

          break;
        case "down":
          moveDown();

          break;
      }
    });
  }

  void getFood() {
    for (int i = 0; i < numberofSquares; i++) {
      if (!barries.contains(i)) {
        foodList.add(i);
      }
    }
  }

  void moveLeft() {
    if (!barries.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void moveRight() {
    if (!barries.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void moveUp() {
    if (!barries.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void moveDown() {
    if (!barries.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0) {
                    direction = "down";
                  } else if (details.delta.dy < 0) {
                    direction = "up";
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0) {
                    direction = "right";
                  } else if (details.delta.dx < 0) {
                    direction = "left";
                  }
                },
                child: Container(
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: numberofSquares,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: numberInRow),
                      itemBuilder: (BuildContext context, int index) {
                        if (mouthClosed && player == index) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        } else if (player == index) {
                          switch (direction) {
                            case "left":
                              return Transform.rotate(
                                angle: pi,
                                child: MyPlayer(),
                              );
                            case "right":
                              return MyPlayer();
                            case "up":
                              return Transform.rotate(
                                angle: 3 + pi / 2,
                                child: MyPlayer(),
                              );

                            case "down":
                              return Transform.rotate(
                                angle: pi / 2,
                                child: MyPlayer(),
                              );
                          }
                        } else if (barries.contains(index)) {
                          return MyPath(
                            innerColor: Colors.blue[700],
                            outerColor: Colors.blue[800],
                          );
                        } else if (foodList.contains(index) || preGame) {
                          return MyPath(
                            innerColor: Colors.yellow,
                            outerColor: Colors.black,
                          );
                        } else {
                          return MyPath(
                            innerColor: Colors.black,
                            outerColor: Colors.black,
                          );
                        }
                      }),
                ),
              )),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Score: ' + score.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
                GestureDetector(
                    onTap: startGame,
                    child: preGame
                        ? const Text(
                            'P L A Y ',
                            style:  TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          )
                        : SizedBox(
                            height: 100,
                            width: 100,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CircularProgressIndicator(
                                  value: 1 - seconds / maxSeconds,
                                  valueColor:
                                  const AlwaysStoppedAnimation(Colors.white),
                                  strokeWidth: 8,
                                  backgroundColor: MainColor.accentColor,
                                ),
                                Center(
                                  child: Text(
                                    '$seconds',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 50,
                                    ),
                                  ),
                                )
                              ],
                            ))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
