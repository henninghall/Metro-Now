import 'package:flutter/material.dart';

class StationText extends StatelessWidget {
  StationText({@required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          "Closest station",
          style:
              Theme.of(context).textTheme.display1.apply(fontSizeFactor: 0.7),
        ),
        SizedBox(height: 20),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .display2
              .apply(fontWeightDelta: 1, fontSizeFactor: 0.8),
        ),
      ],
    ));
  }
}
