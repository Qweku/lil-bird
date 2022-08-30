import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  final birdY;
  final double? birdWidth;
  final double? birdHeight;
  const Bird({Key? key, this.birdY, this.birdWidth, this.birdHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(0, (2 * birdY + birdHeight!)/(2-birdHeight!)),
        
        child: Image.asset('assets/bird2.gif',
        width:MediaQuery.of(context).size.height * birdWidth! / 2,
        height: MediaQuery.of(context).size.height * 3/4 * birdHeight!/2,
        fit: BoxFit.fill,
        ));
  }
}
