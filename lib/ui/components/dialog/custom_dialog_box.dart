import 'dart:ui';
import '../../../constant/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Constants {
  Constants._();
  static const double padding = 8;
  static const double avatarRadius = 45;
}

class CustomDialogBox extends StatefulWidget {
  final String title, text;
  final Widget contentWidget;
  final Widget headWidget;
  final Function onTapButton;
  const CustomDialogBox(
      {Key key,
      this.title,
      this.contentWidget,
      this.onTapButton,
      this.text,
      this.headWidget})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 1000,
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                // BoxShadow(
                // color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: widget.contentWidget,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: widget.onTapButton ??
                      () {
                        FocusScope.of(context).requestFocus(new FocusNode());

                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        EasyLoading.showSuccess("反馈成功");
                      },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: blue,
                      ),
                      padding: EdgeInsets.all(12),
                      child: Text(
                        widget.text,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: widget.headWidget),
          ),
        ),
      ],
    );
  }
}
