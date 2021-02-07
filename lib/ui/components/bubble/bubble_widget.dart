import 'dart:math';

import 'package:SuyuListening/ui/components/bubble/bubble_entity.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class BubbleWidget extends StatefulWidget {
  BubbleWidget({Key key}) : super(key: key);

  @override
  _BubbleWidgetState createState() => _BubbleWidgetState();
}

// 获取颜色的方法
Color getRandomOpacityColor(Random random) {
  return Color.fromARGB(random.nextInt(200), 255, 255, 255);
}

class _BubbleWidgetState extends State<BubbleWidget>
    with SingleTickerProviderStateMixin {
  List<BubbleEntity> _list = [];
  // 随机数
  Random _random = new Random(DateTime.now().microsecondsSinceEpoch);
  // 最大速度
  double _maxSpeed = 0.9;
  // 最大半径
  double _maxRadius = 80;
  // 最大角度
  double _maxTheta = 2 * pi;

  //动画控制
  AnimationController _animationController;
  @override
  void initState() {
    for (int i = 0; i < 20; i++) {
      BubbleEntity bubbleEntity = new BubbleEntity()
        // 颜色
        ..color = getRandomOpacityColor(_random)
        // 位置
        ..position = Offset(-1, -1)
        ..speed = _random.nextDouble() * _maxSpeed
        ..radius = _random.nextDouble() * _maxRadius
        ..theta = _random.nextDouble() * _maxTheta;
      _list.add(bubbleEntity);
      // 获取随机透明度白色
    }
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    // 执行刷新监听
    _animationController.addListener(() {
      setState(() {});
    });

    // 重复执行
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CanvasTouchDetector(builder: (context) {
      return CustomPaint(
          size: MediaQuery.of(context).size,
          painter: CustomMyPainter(context, list: _list, random: _random));
    });
  }
}

class CustomMyPainter extends CustomPainter {
  List<BubbleEntity> list;
  Random random;
  final BuildContext context;

  CustomMyPainter(this.context, {this.list, this.random});

  Paint _paint = new Paint()..isAntiAlias = true;
  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);

    // 计算每个点的位置
    list.forEach((element) {
      Offset newCenterOffset = calculateXY(element.speed, element.theta);

      double dx = newCenterOffset.dx + element.position.dx;
      double dy = newCenterOffset.dy + element.position.dy;

      //碰撞
      if (dx < element.radius ||
          dx > size.width - element.radius ||
          dy < element.radius + 0 ||
          dy > size.height - element.radius) {
        element.speed = -element.speed;
      }

      newCenterOffset = calculateXY(element.speed, element.theta);
      dx = newCenterOffset.dx + element.position.dx;
      dy = newCenterOffset.dy + element.position.dy;

      if (dx < 0 || dx > size.width) {
        dx = random.nextDouble() * size.width;
      }

      if (dy < 0 || dy > size.height) {
        dy = random.nextDouble() * size.height;
      }

      element.position = Offset(dx, dy);
    });

    // 绘制
    list.forEach((element) {
      //修改画笔的颜色
      _paint.color = element.color;
      //绘制圆

      myCanvas.drawCircle(element.position, element.radius, _paint,
          onTapDown: (tapdetail) {
        element.color = Colors.transparent;
        print("被按了");
        list.remove(element);
      });
    });
  }

  //刷新
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Offset calculateXY(double speed, double theta) {
    return Offset(speed * cos(theta), speed * sin(theta));
  }
}
