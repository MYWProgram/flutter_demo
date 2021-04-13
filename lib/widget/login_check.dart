import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class LoginCheck extends StatefulWidget {
  @override
  _LoginCheckState createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  // * 输入框焦点控制
  FocusNode _usernameFocusNode = new FocusNode();
  FocusNode _passwordFocusNode = new FocusNode();
  // * 文本输入控制器
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  // * 抖动动画控制器
  ShakeAnimationController _usernameAnimation = new ShakeAnimationController();
  ShakeAnimationController _passwordAnimation = new ShakeAnimationController();
  // * stream 更新操作控制器，可同时异步接收多个数据并更新组件
  StreamController<String> _usernameSream = new StreamController();
  StreamController<String> _passwordSream = new StreamController();

  Widget _buildLoginWidget() {
    return Container(
      margin: EdgeInsets.all(20.r),
      child: Column(children: <Widget>[
        _buildUsernameWidget(),
        SizedBox(height: 10.h),
        _buildPasswordWidget(),
        SizedBox(height: 20.h),
        Container(
          width: double.infinity,
          height: 40.h,
          child: ElevatedButton(
            child: Text('登录'),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              textStyle: TextStyle(
                fontSize: 16.sp,
                letterSpacing: 2,
              ),
            ),
            onPressed: () {
              _checkLogin();
            },
          ),
        ),
      ]),
    );
  }

  TextStyle _labelStyle() {
    return TextStyle(
      fontSize: 14.sp,
    );
  }

  TextStyle _hintStyle() {
    return TextStyle(
      color: Color(0xFFA1A5B2),
      fontSize: 14.sp,
    );
  }

  TextStyle _errorStyle() {
    return TextStyle(
      fontSize: 14.sp,
    );
  }

  // ? 用户名输入框 Stream 局部更新及 error 提示
  StreamBuilder<String> _buildUsernameWidget() {
    return StreamBuilder<String>(
      stream: _usernameSream.stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return ShakeAnimationWidget(
          shakeAnimationController: _usernameAnimation,
          isForward: false,
          shakeAnimationType: ShakeAnimationType.LeftRightShake,
          child: TextField(
            controller: _usernameController,
            focusNode: _usernameFocusNode,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              labelText: '用户名',
              labelStyle: _labelStyle(),
              hintText: '请输入用户名',
              hintStyle: _hintStyle(),
              errorText: snapshot.data,
              errorStyle: _errorStyle(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.r)),
              ),
            ),
            // * 键盘回车回调
            onSubmitted: (String value) {
              if (_checkUsername()) {
                _usernameFocusNode.unfocus();
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              } else {
                FocusScope.of(context).requestFocus(_usernameFocusNode);
              }
            },
          ),
        );
      },
    );
  }

  // ? 密码输入框 Stream 局部更新及 error 提示
  StreamBuilder<String> _buildPasswordWidget() {
    return StreamBuilder<String>(
        stream: _passwordSream.stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return ShakeAnimationWidget(
            shakeAnimationController: _passwordAnimation,
            isForward: false,
            shakeAnimationType: ShakeAnimationType.LeftRightShake,
            child: TextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                labelText: '密码',
                labelStyle: _labelStyle(),
                hintText: '请输入密码',
                hintStyle: _hintStyle(),
                errorText: snapshot.data,
                errorStyle: _errorStyle(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.r)),
                ),
              ),
              onSubmitted: (String value) {
                if (_checkPassword()) {
                  _login();
                } else {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                }
              },
            ),
          );
        });
  }

  // ? 登录按钮
  void _checkLogin() {
    _hideKeyBoarder();
    _checkUsername();
    _checkPassword();
    _login();
  }

  bool _checkUsername() {
    String username = _usernameController.text;
    if (username.length == 0) {
      // * stream 异步更新提示
      _usernameSream.add('请输入用户名');
      // * 开启抖动动画
      _usernameAnimation.start();
      return false;
    } else {
      // * 清楚错误提示
      _usernameSream.add(null);
      return true;
    }
  }

  bool _checkPassword() {
    String password = _passwordController.text;
    if (password.length < 8) {
      _passwordSream.add('密码不能小于8位');
      _passwordAnimation.start();
      return false;
    } else {
      _passwordSream.add(null);
      return true;
    }
  }

  void _hideKeyBoarder() {
    _usernameFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    // * 隐藏键盘
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void _login() {
    // * 登录操作
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: Text('LoginCheck'),
          elevation: 0,
          backgroundColor: Colors.red,
        ),
        body: _buildLoginWidget(),
      ),
      onTap: () {
        _hideKeyBoarder();
      },
    );
  }
}
