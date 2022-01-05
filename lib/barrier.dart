import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  final size;
  final barWidth;
  final barX;
  final barY;
  final bool isBottom;
  const Barrier({Key key, this.size, this.barWidth, this.barX, this.barY, this.isBottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment(
        (2 * barX + barWidth) / (2 - barWidth), isBottom ? 1.1: -1.1
      ),
      
      child: Container(
        width: MediaQuery.of(context).size.width * barWidth/2,
      height: MediaQuery.of(context).size.height * 3/4 * barY/2,
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Colors.black),
        borderRadius: BorderRadius.circular(20),
        color: theme.primaryColorDark,
      ),
      ),
    );
  }
}
