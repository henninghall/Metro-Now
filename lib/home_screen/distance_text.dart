import 'package:flutter/material.dart';

class DistanceText extends StatelessWidget {
  DistanceText({@required this.distance});
  final int distance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Text(
        "$distance m",
        style: Theme.of(context).textTheme.display3.apply(fontWeightDelta: 3),
      ),
      padding: EdgeInsets.all(8.0),
    );
  }
}
