import 'dart:math';

import 'package:SuyuListening/constant/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class RecordsDetailPage extends StatefulWidget {
  RecordsDetailPage({Key key}) : super(key: key);

  @override
  _RecordsDetailPageState createState() => _RecordsDetailPageState();
}

List<double> _generateRandomData(int count) {
  List<double> result = <double>[];
  for (int i = 0; i < count; i++) {
    result.add((Random().nextInt(i + 5) * 100).toDouble());
  }
  return result;
}

class _RecordsDetailPageState extends State<RecordsDetailPage> {
  var data = _generateRandomData(100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("学习记录"),
      ),
      body: Stack(fit: StackFit.expand, children: [
        Text("121"),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: new Sparkline(
            data: data,
            lineWidth: 1.0,
            lineColor: Colors.black,
            fillMode: FillMode.below,
            fillColor: Colors.red[200],
            fillGradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [yellow, yellow.withAlpha(100)],
            ),

            // lineColor: Colors.lightGreen[500],
            // fillMode: FillMode.below,
            // fillColor: Colors.lightGreen[200],
            // pointsMode: PointsMode.all,
            // pointSize: 5.0,
            // pointColor: Colors.amber,
          ),
        ),
      ]),
    );
  }
}
