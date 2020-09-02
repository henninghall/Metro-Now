import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CenteredText extends StatelessWidget {
  CenteredText({@required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .apply(fontWeightDelta: 3)),
          ),
        ]);
  }
}
