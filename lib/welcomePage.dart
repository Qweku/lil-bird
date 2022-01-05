import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lil_bird/bird.dart';

import 'home.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({Key key}) : super(key: key);

  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  double _currentOpacity = 0;
  double birdX = -1.1;
  bool isLoading = false;
  void _start() {
    isLoading = true;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        birdX += 0.05;
      });

      if (birdX >= -0.3) {
        setState(() {
          _currentOpacity += 0.2;
        });
      }
      if(_currentOpacity ==1){
         setState(() {
          _currentOpacity -= 0.2;
        });
      }

      isLoading = false;
      // Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  void initState() {
    _start();
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: theme.primaryColor,
            child: Stack(
              children: [
                Container(
                    alignment: Alignment(birdX, 0),
                    child: Image.asset('assets/bird2.gif',
                        height: 50, width: 50, fit: BoxFit.fill)),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _currentOpacity,
                  child: Container(
                    alignment: Alignment(0, -0.3),
                    child: Text(
                      "L I L  B I R D",
                      style: theme.textTheme.headline2
                          .copyWith(color: Colors.amber),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 15,
          color: theme.accentColor,
        ),
        Expanded(child: Container(color: Colors.brown,
        child:Center(child:Text('B y :  Q w e k u  W e d n e s d a y', style:theme.textTheme.headline4))))
      ],
    ));
  }
}
