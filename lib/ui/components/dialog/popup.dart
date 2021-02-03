import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showPopup(
  BuildContext context,
  Function onTap, {
  String title = "oh-ooh",
  String imageUrl = "assets/images/popup/success.JPG",
  String describe =
      "Your guitar is tuned and now you are ready to hit the stage and rock!",
  String buttonTitle = "Tune Guitar",
  Color buttonColor = Colors.red,
}) {
  showGeneralDialog(
      barrierLabel: 'label',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 750.h,
            width: 620.w,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Material(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox.shrink(),
                        IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                    Image.asset(
                      imageUrl,
                      height: 300.h,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: buttonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 45.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      describe,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 70.h,
                      width: 235.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(30),
                        color: buttonColor,
                        child: FlatButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            onTap();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Text(
                                buttonTitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
