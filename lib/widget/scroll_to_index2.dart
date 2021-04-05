import 'package:flutter/material.dart';
import 'dart:math' as math;

class ScrollToIndex2 extends StatefulWidget {
  @override
  _ScrollToIndexState2 createState() => _ScrollToIndexState2();
}

class _ScrollToIndexState2 extends State<ScrollToIndex2> {
  GlobalKey scrollKey = GlobalKey();
  ScrollController controller = new ScrollController();
  List<ItemModel> dataList = [];

  @override
  void initState() {
    dataList.clear();
    for (int i = 0; i < 100; i++) {
      dataList.add(new ItemModel(i));
    }
    super.initState();
  }

  _scrollToIndex() {
    var key = dataList[55];
    RenderBox renderBox = key.globalKey.currentContext.findRenderObject();
    // * 获取位置偏移，基于 ancestor: SingleChildScrollView 的 RenderObject()
    double dy = renderBox.localToGlobal(
      Offset.zero,
      ancestor: scrollKey.currentContext.findRenderObject()
    ).dy;
    // * 计算真实位移
    double offset = dy + controller.offset;
    controller.animateTo(offset, duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text('ScrollToIndex2'),
        ),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: dataList.map<Widget>((data) {
              return CardItem(data, key: dataList[data.index].globalKey);
            }).toList(),
          ),
          key: scrollKey,
          controller: controller,
        ),
      ),
      persistentFooterButtons: <Widget>[
        ElevatedButton(
          child: Text('Scroll to No.55'),
          style: ElevatedButton.styleFrom(primary: Colors.red),
          onPressed: () => _scrollToIndex(),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          child: Icon(Icons.arrow_upward),
          style: ElevatedButton.styleFrom(primary: Colors.red),
          onPressed: () => controller.animateTo(0, duration: Duration(seconds: 1), curve: Curves.bounceInOut),
        ),
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  final random = math.Random();
  final ItemModel data;
  CardItem(this.data, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Container(
          child: Text('Item ${data.index}'),
          margin: EdgeInsets.all(8),
        ),
        height: (math.max(300 * random.nextDouble(), 50)),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}

class ItemModel {
  GlobalKey globalKey = new GlobalKey();
  final int index;
  ItemModel(this.index);
}
