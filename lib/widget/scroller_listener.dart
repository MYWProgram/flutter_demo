import 'package:flutter/material.dart';

class ScrollerListener extends StatefulWidget {
  @override
  _ScrollerListenerState createState() => _ScrollerListenerState();
}

class _ScrollerListenerState extends State<ScrollerListener> {
  final ScrollController _scrollController = new ScrollController();
  bool isTop = true;
  bool isEnd = false;
  double offset = 0;
  String notify = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset;
        isEnd = _scrollController.position.pixels == _scrollController.position.maxScrollExtent;
        isTop = _scrollController.position.atEdge && _scrollController.position.pixels == 0;
        print(isEnd);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScrollerListener'),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: NotificationListener(
          onNotification: (notification) {
            String _notify = '';
            switch (notification.runtimeType) {
              case ScrollStartNotification:
                _notify = '开始滚动';
                break;
              case ScrollUpdateNotification:
                _notify = '滚动中';
                break;
              case ScrollEndNotification:
                _notify = '停止滚动';
                break;
              case UserScrollNotification:
                _notify = '可滚动';
                break;
              case OverscrollNotification:
                _notify = '停靠边界';
                break;
            }
            setState(() {
              this.notify = _notify;
            });
            return false;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  child: Text('Item $index'),
                  alignment: Alignment.centerLeft,
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                ),
              );
            },
            itemCount: 100,
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        Text('距离顶部: ${offset.floor()}'),
        Text('当前状态: $notify'),
        Visibility(
          visible: isTop,
          child: Text(
            '在顶部',
            style: TextStyle(color: Colors.green),
          ),
        ),
        Visibility(
          visible: isEnd,
          child: Text(
            '到底了',
            style: TextStyle(color: Colors.red),
          ),
        ),
        ElevatedButton(
          child: Icon(Icons.arrow_upward),
          // * 两种修改自带 Button 样式的方法。
          style: ElevatedButton.styleFrom(primary: Colors.red),
          // style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red)),
          onPressed: () => _scrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.bounceInOut),
        ),
      ],
    );
  }
}
