import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/controller_demo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        title: 'Flutter Demo',
      ),
      routes: router,
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
        elevation: 0.5,
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return new InkWell(
              onTap: () => Navigator.of(context).pushNamed(routeList[index]),
              child: Card(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  child: Text(router.keys.toList()[index]),
                ),
              ),
            );
          },
          itemCount: router.length,
        ),
      ),
    );
  }
}

Map<String, WidgetBuilder> router = {
  "文本输入框简单的 Controller": (context) => new ControllerDemoPage(),
};
