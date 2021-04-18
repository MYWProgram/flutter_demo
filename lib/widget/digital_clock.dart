import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DigitalClock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DigitalClockState();
  }
}

class _DigitalClockState extends State<DigitalClock> {
  Timer _timer;
  List<int> _time = List.filled(6, 0);

  void startTimer() {
    // * 定义更新的时间间隔
    const oneSec = const Duration(seconds: 1);
    // * 定义时、分、秒的变量
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          var now = new DateTime.now();
          var hour = now.hour;
          _time[0] = hour ~/ 10;
          _time[1] = hour % 10;
          var minute = now.minute;
          _time[2] = minute ~/ 10;
          _time[3] = minute % 10;
          var second = now.second;
          _time[4] = second ~/ 10;
          _time[5] = second % 10;
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DigitalClock'),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: Row(
        children: <Widget>[
          SizedBox(height: 450.h),
          CustomPaint(painter: DigitalNumberPainter(number: _time[0])),
          SizedBox(width: 50.w),
          CustomPaint(painter: DigitalNumberPainter(number: _time[1])),
          SizedBox(width: 80.w),
          CustomPaint(painter: DigitalNumberPainter(number: _time[2])),
          SizedBox(width: 50.w),
          CustomPaint(painter: DigitalNumberPainter(number: _time[3])),
          SizedBox(width: 80.w),
          CustomPaint(painter: DigitalNumberPainter(number: _time[4])),
          SizedBox(width: 50.w),
          CustomPaint(painter: DigitalNumberPainter(number: _time[5])),
        ],
      ),
    );
  }
}

class DigitalNumberPainter extends CustomPainter {
  var funList = [];
  // * 时钟上的每一个数字先横后竖等分为 7 份，使用布尔值控制哪一份需要绘制
  Map digitalMap = {
    0: [true, false, true, true, true, true, true],
    1: [false, false, false, false, false, true, true],
    2: [true, true, true, false, true, true, false],
    3: [true, true, true, false, false, true, true],
    4: [false, true, false, true, false, true, true],
    5: [true, true, true, true, false, false, true],
    6: [true, true, true, true, true, false, true],
    7: [true, false, false, true, false, true, true],
    8: [true, true, true, true, true, true, true],
    9: [true, true, true, true, false, true, true],
  };
  int number;

  DigitalNumberPainter({this.number = 0}) {
    Paint paint = new Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.w;

    double padding = 8.r;
    double rowWidth = 32.w;
    double columnHeight = 36.h;

    for (int i = 0; i < 3; i++) {
      double height = columnHeight * i + padding;
      Offset p1 = new Offset(padding + padding, height);
      Offset p2 = new Offset(rowWidth, height);
      funList.add((Canvas canvas) {
        canvas.drawLine(p1, p2, paint);
      });
    }

    for (int i = 0; i < 2; i++) {
      double width = rowWidth * i + padding;
      Offset p1 = new Offset(width, padding + padding);
      Offset p2 = new Offset(width, columnHeight);
      funList.add((Canvas canvas) {
        canvas.drawLine(p1, p2, paint);
      });
      Offset p3 = new Offset(width, padding + padding + columnHeight);
      Offset p4 = new Offset(width, columnHeight + columnHeight);
      funList.add((Canvas canvas) {
        canvas.drawLine(p3, p4, paint);
      });
    }
  } //  MyPainter({this.lineColor, this.completeColor, this.completePercent, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    List<bool> num = digitalMap[number];
    if (num == null) return;
    for (int i = 0; i < 7; i++) {
      if (num[i] && funList[i] != null) {
        funList[i](canvas);
      }
    }
  }

  @override
  bool shouldRepaint(DigitalNumberPainter oldDelegate) {
    // * 需要在时钟数字改变时重绘
    return number != oldDelegate.number;
  }
}
