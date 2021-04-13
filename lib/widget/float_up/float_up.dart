import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './dep_floating_button.dart';

class FloatUp extends StatefulWidget {
  @override
  _FloatUpState createState() => _FloatUpState();
}

class _FloatUpState extends State<FloatUp> {
  List<Icon> iconList = [
    Icon(Icons.add),
    Icon(Icons.save_alt_outlined),
    Icon(Icons.share),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FloatUp'),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 33.w,
              bottom: 33.h,
              child: DepFloatingButton(
                iconList: iconList,
                clickCallback: (int index) {
                  print('点击了$index');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
