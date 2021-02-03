library emoji_feedback;

import 'dart:math';
import 'package:flutter/material.dart';

class EmojiModel {
  final String label;
  final String src;
  final String activeSrc;
  const EmojiModel({this.src, this.activeSrc, this.label});
}

final List<EmojiModel> reactions = <EmojiModel>[
  EmojiModel(
      label: '超级难',
      src: 'assets/worried.png',
      activeSrc: 'assets/worried_big.png'),
  EmojiModel(
      label: '一般难', src: 'assets/sad.png', activeSrc: 'assets/sad_big.png'),
  EmojiModel(
      label: '正好',
      src: 'assets/ambitious.png',
      activeSrc: 'assets/ambitious_big.png'),
  EmojiModel(
      label: '挺简单的',
      src: 'assets/smile.png',
      activeSrc: 'assets/smile_big.png'),
  EmojiModel(
      label: '超简单',
      src: 'assets/surprised.png',
      activeSrc: 'assets/surprised_big.png'),
].toList();

const EmojiSize = 40.0;
const EmojiRadius = EmojiSize / 2.0;
const ActiveEmojiSize = EmojiSize * 1.5;
const ActiveEmojiRadius = ActiveEmojiSize / 2.0;
const HalfDiffSize = (ActiveEmojiSize - EmojiSize) / 2.0;

class EmojiFeedback extends StatefulWidget {
  final int currentIndex;
  final Function onChange;
  final num availableWidth;

  const EmojiFeedback({
    Key key,
    this.currentIndex = 2,
    this.onChange,
    this.availableWidth = 320.0,
  }) : super(key: key);

  @override
  EmojiFeedbackState createState() {
    return new EmojiFeedbackState();
  }
}

class EmojiFeedbackState extends State<EmojiFeedback>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  double pos = 2.0; // should be between [0, 4]

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );
  }

  void moveTo(int index) {
    animation = Tween<double>(
      begin: pos,
      end: index.toDouble(),
    ).chain(CurveTween(curve: Curves.linear)).animate(controller)
      ..addListener(() {
        setState(() {
          pos = animation.value;
        });
      });
    controller.forward(from: 0.0);
    if (widget.onChange is Function) {
      widget.onChange(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final posTween =
        Tween<double>(begin: 0, end: widget.availableWidth - ActiveEmojiSize);
    List<_EmojiButton> emojiButtons = [];
    List<Widget> activeEmojis = [];
    for (var i = 0; i < reactions.length; i++) {
      final distanceTo = posTween.transform((i - pos).abs() / 4);
      var scale = 1.0;
      if (distanceTo < ActiveEmojiRadius) {
        scale = 0.0;
      } else {
        scale =
            min<double>((distanceTo - ActiveEmojiRadius) / EmojiRadius, 1.0);
      }
      emojiButtons.add(_EmojiButton(
        scale: scale,
        label: reactions[i].label,
        src: reactions[i].src,
        onPressed: () {
          moveTo(i);
        },
      ));
      activeEmojis.add(
        Positioned(
          child: Opacity(
            opacity: 1.0 - scale,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    reactions[i].activeSrc,
                    package: 'emoji_feedback',
                  ),
                ),
                borderRadius: BorderRadius.circular(ActiveEmojiSize),
              ),
            ),
          ),
        ),
      );
    }
    return Container(
      width: widget.availableWidth,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: ActiveEmojiRadius,
            left: ActiveEmojiRadius,
            right: ActiveEmojiRadius,
            child: Container(
              height: 1.0,
              color: Colors.grey,
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: emojiButtons,
            ),
          ),
          Positioned(
            left: posTween.transform(pos / 4),
            child: Container(
              width: ActiveEmojiSize,
              height: ActiveEmojiSize,
              child: Stack(
                children: activeEmojis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _EmojiButton extends StatelessWidget {
  final VoidCallback onPressed;
  final num scale;
  final String label;
  final String src;

  const _EmojiButton({
    Key key,
    @required this.onPressed,
    this.scale,
    @required this.label,
    @required this.src,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(scale >= 0 && scale <= 1);
    final offsetTop = Tween<double>(begin: 16.0, end: 6.0).transform(scale);
    final realScale = Tween<double>(begin: 0.25, end: 1.0).transform(scale);
    final color =
        ColorTween(begin: Colors.black, end: Colors.grey).transform(scale);
    return Container(
      width: ActiveEmojiSize,
      padding: EdgeInsets.only(top: HalfDiffSize),
      child: Column(
        children: <Widget>[
          Transform.scale(
            scale: realScale,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: onPressed,
              child: Container(
                width: EmojiSize,
                height: EmojiSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(src, package: 'emoji_feedback'),
                  ),
                  borderRadius: BorderRadius.circular(EmojiSize),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: offsetTop),
            child: Text(
              label,
              style: Theme.of(context).textTheme.caption.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
