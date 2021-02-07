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
        ),
        buildBackground(),
      ],
    );
  }

  Widget buildBackground() {
    return Image.asset(
      'assets/earth.png',
      fit: BoxFit.contain,
    );
  }
}
