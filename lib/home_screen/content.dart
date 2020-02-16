import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metro_now/bloc/app_bloc.dart';
import 'package:metro_now/bloc/app_state.dart';
import 'package:metro_now/images/arrow_image.dart';

import 'distance_text.dart';
import 'station_text.dart';

class Content extends StatefulWidget {
  Content({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Content> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (BuildContext context, state) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              StationText(text: state.stationName),
              Container(
                alignment: Alignment.center,
                child: new Transform.rotate(
                  angle: state.angle,
                  child: arrowImage,
                ),
              ),
              DistanceText(distance: state.distance),
            ]);
      },
    );
  }
}
