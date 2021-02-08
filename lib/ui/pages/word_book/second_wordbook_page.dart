import 'package:SuyuListening/constant/theme_color.dart';
import 'package:flutter/material.dart';

class SecondWordBookPage extends StatelessWidget {
  const SecondWordBookPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: silver,
          child: Center(
            child: Text(
              "开发中",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        buildBackground(),
      ],
    );
  }

  Widget buildBackground() {
    return Opacity(
      opacity: 0.2,
      child: Image.asset(
        'assets/earth.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
