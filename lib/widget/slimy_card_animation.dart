import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slimy_card/slimy_card.dart';

class SlimyCardAnimation extends StatefulWidget {
  @override
  _SlimyCardAnimationState createState() => _SlimyCardAnimationState();
}

class _SlimyCardAnimationState extends State<SlimyCardAnimation> {
  TextStyle bottomTextStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    );
  }

  Widget topCardWidget(String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 70.r,
          height: 70.r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20.r,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          '猫',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 15.h),
        Center(
          child: Text(
            '这是一只猫。',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget bottomCardWidget() {
    return Column(
      children: <Widget>[
        Text(
          'Cat',
          style: bottomTextStyle(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15.h),
        Expanded(
          child: Text(
            'This is a cat.',
            style: bottomTextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SlimyCardAnimation'),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder(
        initialData: false,
        stream: slimyCard.stream,
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: 70.h),
              SlimyCard(
                color: Colors.red,
                topCardWidget: topCardWidget('assets/images/cat.jpg'),
                bottomCardWidget: bottomCardWidget(),
                bottomCardHeight: 100,
              ),
            ],
          );
        }),
      ),
    );
  }
}
