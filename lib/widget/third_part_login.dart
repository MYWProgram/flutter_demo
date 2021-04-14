import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThirdPartLogin extends StatefulWidget {
  @override
  _ThirdPartLoginState createState() => _ThirdPartLoginState();
}

class _ThirdPartLoginState extends State<ThirdPartLogin> {
  String resultMessage = '--';

  // ? 构建子项
  Widget _buildItem(String title, String imagePath, {Function onTap}) {
    return InkWell(
        child: Container(
          height: 45.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imagePath,
                width: 20.r,
                height: 20.r,
              ),
              SizedBox(width: 10.w),
              Text(title),
            ],
          ),
        ),
        onTap: () {
          // * 点击子项后关闭弹窗
          Navigator.of(context).pop();
          if (onTap != null) {
            onTap();
          }
        });
  }

  // ? 构建容纳子项的底部框
  Widget _buildBottomSheetWidget(BuildContext context) {
    return Container(
      height: 180.h,
      child: Column(
        children: <Widget>[
          _buildItem('微信登录', 'assets/images/wx.png', onTap: () {
            setState(() {
              resultMessage = '微信登录';
            });
          }),
          _buildItem('QQ登录', 'assets/images/qq.png', onTap: () {
            setState(() {
              resultMessage = 'QQ登录';
            });
          }),
          _buildItem('掘金登录', 'assets/images/juejin.png', onTap: () {
            setState(() {
              resultMessage = '掘金登录';
            });
          }),
          _buildItem('密码登录', 'assets/images/password.png', onTap: () {
            setState(() {
              resultMessage = '密码登录';
            });
          }),
        ],
      ),
    );
  }

  // ? 显示底部弹框功能
  void _showBottonSheet() {
    // * 使用底部弹出框
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomSheetWidget(context);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ThirdPartLogin'),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('选择登录方式'),
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () => _showBottonSheet(),
            ),
            Text('登录方式：$resultMessage'),
          ],
        ),
      ),
    );
  }
}
