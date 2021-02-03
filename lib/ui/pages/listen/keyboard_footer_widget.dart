import 'package:SuyuListening/config/styled_text_config.dart';
import 'package:SuyuListening/provider/listen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:styled_text/styled_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget keyBoardFooterWidget(context) => PreferredSize(
  preferredSize: Size.fromHeight(120.h),
  child: SizedBox(
    height: 120.h,
    child: Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity:
            Provider.of<ListenProvider>(context, listen: true).showCheckText
                ? 1.0
                : 0.0,
        child: StyledText(
          text: Provider.of<ListenProvider>(context, listen: true).checkText,
          styles: styledTextConfig,
        ),
      ),
    ),
  ),
);
