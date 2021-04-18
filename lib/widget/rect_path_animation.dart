import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RectPathAnimation extends StatefulWidget {
  @override
  _RectPathAnimationState createState() => _RectPathAnimationState();
}

class _RectPathAnimationState extends State<RectPathAnimation> with SingleTickerProviderStateMixin {
  // * 动画控制器
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // * 定义动画控制器并设置动画监听
    _animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
      ..addListener(() {
        setState(() {});
      });
    // * 添加动画状态监听
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // * 动画正向执行完成时重新执行
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  Widget _buildContainer() {
    return Container(
      child: CustomPaint(
        painter: PathPainter(_animationController.value),
      ),
    );
  }

  Widget _buildControllerContainer() {
    return Container(
      margin: EdgeInsets.only(bottom: 48.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: Text('Start'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () {
              _animationController.reset();
              _animationController.forward();
            },
          ),
          SizedBox(width: 20.w),
          ElevatedButton(
            child: Text('End'),
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () {
              _animationController.reset();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RectPathAnimation'),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildContainer(),
          ),
          _buildControllerContainer(),
        ],
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  double progress = 0.0;
  PathPainter(this.progress);
  // * 定义画笔
  Paint _paint = new Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 6.0
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    // * 创建 Path
    Path _startPath = new Path();
    // * 路径中添加矩形
    _startPath.addRect(
      Rect.fromCenter(
        width: 100.r,
        height: 100.r,
        center: Offset(100.r, 100.r),
      ),
    );
    // * 测量 Path
    PathMetrics _pathMetrics = _startPath.computeMetrics();
    // * 获取第一小节信息
    PathMetric _pathMetric = _pathMetrics.first;
    // * 测量并裁剪 Path
    Path _extrPath = _pathMetric.extractPath(0, _pathMetric.length * progress);
    // * 绘制
    canvas.drawPath(_extrPath, _paint);
    // canvas.drawPath(_startPath, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // * 返回 true，实时更新
    return true;
  }
}
