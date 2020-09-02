import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/app_bloc.dart';
import 'home_screen/home.dart';
import 'package:flutter/services.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
          fontSizeFactor: 1.2,
        );

    var theme = ThemeData(
        primarySwatch: Colors.blue,
        textTheme: newTextTheme,
        appBarTheme: AppBarTheme(brightness: Brightness.dark));

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, // Color for Android
        statusBarBrightness:
            Brightness.dark // Dark == white status bar -- for IOS.
        ));

    return MaterialApp(
      title: 'Finding Metro',
      theme: theme,
      home: BlocProvider<AppBloc>(
        create: (context) => AppBloc(),
        child: Home(),
      ),
    );
  }
}
