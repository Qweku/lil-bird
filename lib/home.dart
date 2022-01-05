import 'dart:async';
import 'dart:io';

import 'package:lil_bird/barrier.dart';
import 'package:flutter/material.dart';

import 'bird.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static double vAxis = 0;
  double height = 0;
  double time = 0;
  double initHeight = vAxis;
  double birdHeight = 0.15;
  double birdWidth = 0.15;
  double speed = 0.03;
  int score = 0;
  int highScore = 0;
  bool isStarted = false;

  static List<double> barX = [2, 2 + 1.5];
  static double barWidth = 0.5;
  List<List<double>> barY = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  void bounce() {
    setState(() {
      time = 0;
      initHeight = vAxis;
    });
  }

  void reset() {
    Navigator.pop(context);
    setState(() {
      vAxis = 0;
      isStarted = false;
      time = 0;
      initHeight = vAxis;
      barX = [2, 2 + 1.5];
      barY = [
        [0.6, 0.4],
        [0.4, 0.6]
      ];
      score = 0;
    });
  }

  void gameStart() {
    isStarted = true;
    initHeight = vAxis;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      time += 0.01;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        vAxis = initHeight - height;
      });
      setState(() {
        if (barX[0] < -2) {
          barX[0] += 3.5;
        } else {
          barX[0] -= speed;
        }
      });
      setState(() {
        if (barX[1] < -2) {
          barX[1] += 3.5;
        } else {
          barX[1] -= speed;
        }
      });

      if (isDead()) {
        timer.cancel();
        isStarted = false;
        _showDialog();
      }

      if (barX[0] < -0.2 && barX[1] < -0.2) {
        setState(() {
          score += 1;
        });
      }
    });
  }

  bool isDead() {
    if (vAxis > 1 || vAxis < -1) {
      return true;
    }
    for (int i = 0; i < barX.length; i++) {
      if (barX[i] <= birdWidth &&
          barX[i] + barWidth >= birdWidth &&
          (vAxis + birdHeight >= 1 - barY[i][1])) {
        return true;
      }
    }
    return false;
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          final theme = Theme.of(context);
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text('GAME OVER',
                textAlign: TextAlign.center,
                style: theme.textTheme.headline4.copyWith(
                    color: Colors.amber, fontWeight: FontWeight.bold)),
            content: Text(
              'SCORE: ' + '$score',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText2,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (score > highScore) {
                    highScore = score;
                  }
                  reset();
                },
                child: Text(
                  "PLAY AGAIN",
                  style: theme.textTheme.button,
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: GestureDetector(
        onTap: () {
          if (isStarted) {
            bounce();
          } else {
            gameStart();
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    color: theme.primaryColor,
                    child: Stack(
                      children: [
                        Bird(
                          birdY: vAxis,
                          birdHeight: birdHeight,
                          birdWidth: birdWidth,
                        ),
                        Container(
                          alignment: Alignment(0, -0.3),
                          child: isStarted
                              ? Text('')
                              : Text(
                                  " T A P  T O  P L A Y",
                                  style: theme.textTheme.headline4,
                                ),
                        ),
                        Barrier(
                          barX: barX[0],
                          barWidth: barWidth,
                          barY: barY[0][0],
                          isBottom: false,
                        ),
                        Barrier(
                          barX: barX[0],
                          barWidth: barWidth,
                          barY: barY[0][1],
                          isBottom: true,
                        ),
                        Barrier(
                          barX: barX[1],
                          barWidth: barWidth,
                          barY: barY[1][0],
                          isBottom: false,
                        ),
                        Barrier(
                          barX: barX[1],
                          barWidth: barWidth,
                          barY: barY[1][1],
                          isBottom: true,
                        )
                      ],
                    ),
                  )),
              Container(height: 15, color: theme.accentColor),
              Expanded(
                  child: Container(
                color: Colors.brown,
                child: Center(
                  child: Container(
                    height: 150,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.amber, width: 5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(1, 2),
                            blurRadius: 5,
                            //spreadRadius: 1
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("SCORE", style: theme.textTheme.headline4),
                            SizedBox(height: 15),
                            Text("$score",
                                style: theme.textTheme.headline4
                                    .copyWith(fontSize: 25))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("BEST", style: theme.textTheme.headline4),
                            SizedBox(height: 15),
                            Text("$highScore",
                                style: theme.textTheme.headline4
                                    .copyWith(fontSize: 25))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
   Future<bool> _onBackPressed(BuildContext context) async {
    return (await showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
              
                  title: Center(child: Text("Warning", )),
                  content: Text("Do you really want to quit?", textAlign: TextAlign.center,
                      ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          exit(0);
                        },
                        child:
                            Text("Yes", )),
                    TextButton(
                        onPressed: () => Navigator.pop(c, false),
                        child: Text("No", ))
                  ],
                ))) ??
        false;
  }

}
