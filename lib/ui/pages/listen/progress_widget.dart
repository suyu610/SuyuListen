import 'package:SuyuListening/constant/theme_color.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../provider/listen_provider.dart';
import 'package:flutter/material.dart';

class ProgressWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProgressWidgetState();
  }
}

// 进度条
class _ProgressWidgetState extends State<ProgressWidget> {
  AudioPlayer player;
  @override
  void initState() {
    player =
        Provider.of<ListenProvider>(context, listen: false).getPlayerInstance();
    // _maxValue = player.duration.inMinutes.toDouble();
    super.initState();
  }

  double _maxValue = 0;
  @override
  Widget build(BuildContext context) {
    if (player.duration != null) {
      print(player.duration.inMilliseconds);
      _maxValue = player.duration.inMilliseconds.toDouble();
      setState(() {});
    } else {
      _maxValue = 100000;
    }
    return Container(
      padding: EdgeInsets.only(right: 6, left: 6),
      child: StreamBuilder<Duration>(
        stream: player.durationStream,
        builder: (context, snapshot) {
          final duration = snapshot.data ?? Duration.zero;
          return StreamBuilder<Duration>(
            stream: player.positionStream,
            builder: (context, snapshot) {
              var position = snapshot.data ?? Duration.zero;
              if (position > duration) {
                position = duration;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50.h,
                    child: FlutterSlider(
                      handler: FlutterSliderHandler(
                        decoration: BoxDecoration(),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(width: 2)),
                            child: Icon(
                              Icons.play_arrow,
                              size: 40.sp,
                            )),
                      ),
                      tooltip: FlutterSliderTooltip(disabled: true),
                      jump: true,
                      trackBar: FlutterSliderTrackBar(
                        inactiveTrackBarHeight: 10.h,
                        activeTrackBarHeight: 10.h,
                        inactiveTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        activeTrackBar: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: yellow),
                      ),
                      values: [
                        (player.position ?? Duration(milliseconds: 100000))
                            .inMilliseconds
                            .toDouble(),
                        (player.duration ?? Duration(milliseconds: 100000))
                            .inMilliseconds
                            .toDouble()
                      ],
                      max:
                          _maxValue, //player.duration.inMilliseconds.toDouble() ?? 0,
                      min: 0,
                      maximumDistance: 10000,
                      rtl: false,
                      handlerAnimation: FlutterSliderHandlerAnimation(
                          curve: Curves.elasticOut,
                          reverseCurve: null,
                          duration: Duration(milliseconds: 700),
                          scale: 1.4),
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        print(lowerValue);
                        player
                            .seek(Duration(milliseconds: (lowerValue).round()));
                        setState(() {});
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 18.0),
                        child: Text(
                          (position.inSeconds ~/ 60).toString() +
                              ":" +
                              (((position.inSeconds % 60) < 10)
                                  ? "0" + (position.inSeconds % 60).toString()
                                  : (position.inSeconds % 60).toString()),
                          style:
                              TextStyle(fontSize: 24.sp, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Text(
                          (duration.inSeconds ~/ 60).toString() +
                              ":" +
                              (((duration.inSeconds % 60) < 10)
                                  ? "0" + (duration.inSeconds % 60).toString()
                                  : (duration.inSeconds % 60).toString()),
                          style:
                              TextStyle(fontSize: 24.sp, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
