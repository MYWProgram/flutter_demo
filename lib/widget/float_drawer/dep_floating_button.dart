import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';

class DepFloatingButton extends StatefulWidget {
  final List<Icon> iconList;
  final Function(int index) clickCallback;
  DepFloatingButton({this.iconList, this.clickCallback});

  @override
  _DepFloatingButtonState createState() => _DepFloatingButtonState();
}

class _DepFloatingButtonState extends State<DepFloatingButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  // * 动画控制器
  AnimationController _animationController;
  // * 颜色变化取值
  Animation<Color> _animationColor;
  // * 图标变化取值
  Animation<double> _animationIcon;
  // * 按钮位置动画
  Animation<double> _translateButton;
  // * 动画执行速率
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56;

  // ? 构建固定旋转菜单按钮
  Widget _floatButton() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _animationColor.value,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationIcon,
        ),
        onPressed: _floatClick,
      ),
    );
  }

  // ? 控制按钮动画变换
  void _floatClick() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  @override
  void initState() {
    super.initState();
    // * 初始化动画控制器并添加监听
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    // * 图标过渡动画
    _animationIcon = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
    // * 实现 color 的过渡动画
    _animationColor = ColorTween(
      begin: Colors.red,
      end: Colors.deepPurple,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0,
        1,
        curve: _curve,
      ),
    ));
    // * 实现按钮位置动画
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0,
        0.75,
        curve: _curve,
      ),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> itemList = [];
    for (int i = 0; i < widget.iconList.length; i++) {
      // * 通过 Transform 来进行 FloatingButton 的平移
      itemList.add(Transform(
        transform: Matrix4.translationValues(
          0,
          _translateButton.value * (widget.iconList.length - i),
          0,
        ),
        child: FloatingActionButton(
          heroTag: '$i',
          backgroundColor: Colors.red,
          child: widget.iconList[i],
          onPressed: () {
            // * 点击菜单子项菜单收回
            _floatClick();
            if (widget.clickCallback != null) {
              widget.clickCallback(i);
            }
          },
        ),
      ));
    }
    itemList.add(_floatButton());
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: itemList,
    );
  }
}
