import 'package:SuyuListening/constant/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FancyButton extends StatelessWidget {
  final String label;
  final Function onPress;
  final LinearGradient gradient;
  final Icon icon;
  FancyButton({this.label = "", this.onPress, this.icon, this.gradient});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
        side: BorderSide(color: Colors.white, width: 2.0),
      ),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.all(
            Radius.circular(14.0),
          ),
        ),
        child: Container(
            width: double.infinity,
            height: 80.0.h,
            alignment: Alignment.center,
            child: icon ??
                Text(
                  '$label',
                  style: TextStyle(
                    color: purple,
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )),
      ),
      onPressed: onPress,
    );
  }
}
