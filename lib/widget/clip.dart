import 'package:flutter/material.dart';

class Clip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text(
            'Clip',
            style: TextStyle(color: Colors.white),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('BoxDecoration 圆角内包 image 属性'),
            SizedBox(height: 10),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/cat.jpg'),
                ),
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('BoxDecoration 圆角 + Image Widget'),
            SizedBox(height: 10),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Image.asset(
                'assets/images/cat.jpg',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text('ClipRRect 圆角 + Image Widget'),
            SizedBox(height: 10),
            // * ClipRRect: 将 child 裁剪为圆角矩形。
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              child: Image.asset(
                'assets/images/cat.jpg',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
