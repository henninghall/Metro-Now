import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class StationText extends StatelessWidget {
  StationText({@required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            "Closest station",
            style:
                Theme.of(context).textTheme.display1.apply(fontSizeFactor: 0.7),
          ),
          SizedBox(height: 20),
          AutoSizeText(
            text,
            style: Theme.of(context)
                .textTheme
                .headline3
                .apply(fontWeightDelta: 1, fontSizeFactor: 0.8),
            maxLines: 1,
          ),
        ],
      )),
    );
  }
}
