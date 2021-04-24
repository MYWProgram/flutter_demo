import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_demo/widget/scroller_listener.dart';
import 'package:flutter_demo/widget/login_check.dart';
import 'package:flutter_demo/widget/float_drawer/float_drawer.dart';
import 'package:flutter_demo/widget/third_part_login.dart';
import 'package:flutter_demo/widget/rect_path_animation.dart';
import 'package:flutter_demo/widget/digital_clock.dart';
import 'package:flutter_demo/widget/slimy_card_animation.dart';
import 'package:flutter_demo/widget/foldable_sidebar/foldable_sidebar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 667),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage(
          title: 'Flutter Demo',
        ),
        routes: router,
        // * 不显示 debug 标签
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var routeList = router.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
          alignment: Alignment.center,
        ),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return new InkWell(
              child: Card(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 10.h),
                  height: 36.h,
                  child: Text(router.keys.toList()[index]),
                ),
              ),
              onTap: () => Navigator.of(context).pushNamed(routeList[index]),
            );
          },
          itemCount: router.length,
        ),
      ),
    );
  }
}

Map<String, WidgetBuilder> router = {
  '列表滑动监听': (context) => new ScrollerListener(),
  '登陆校验': (context) => new LoginCheck(),
  '浮动抽屉': (context) => new FloatDrawer(),
  '三方登录': (context) => new ThirdPartLogin(),
  '画布动画': (context) => new RectPathAnimation(),
  '数字时钟': (context) => new DigitalClock(),
  '黏贴卡片': (context) => new SlimyCardAnimation(),
  '折叠侧边栏': (context) => new FoldableSidebar(),
};
