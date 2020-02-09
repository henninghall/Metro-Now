import 'package:flutter/material.dart';

import 'home_screen/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
          fontSizeFactor: 1.2,
        );

    var theme = ThemeData(primarySwatch: Colors.blue, textTheme: newTextTheme);

    return MaterialApp(
      title: 'Metro Now',
      theme: theme,
      home: Home(),
    );
  }
}
