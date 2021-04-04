import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'dart:math' as math;

class ScrollToIndex extends StatefulWidget {
  @override
  _ScrollToIndexState createState() => _ScrollToIndexState();
}

class _ScrollToIndexState extends State<ScrollToIndex> {
  static const maxCount = 100;
  final random = math.Random();
  final scrollDirection = Axis.vertical;
  AutoScrollController controller;
  List<List<int>> randomList;

  @override
  initState() {
    super.initState();
    controller = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection
    );
    randomList = List.generate(maxCount, (index) => <int>[index, (1000 * random.nextDouble()).toInt()]);
  }

  Widget _getRow(int index, double height) {
    return _wrapScrollTag(
      index: index,
      child: Container(
        child: Text('index: $index, height: $height'),
        height: height,
        padding: EdgeInsets.all(8),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _wrapScrollTag({int index, Widget child}) => AutoScrollTag(
    child: child,
    key: ValueKey(index),
    controller: controller,
    index: index,
    highlightColor: Colors.red.withOpacity(0.1),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text('ScrollToIndex'),
        ),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: ListView(
          scrollDirection: scrollDirection,
          controller: controller,
          children: randomList.map<Widget>((data) {
            return Padding(
              child: _getRow(data[0], math.max(data[1].toDouble(), 50.0)),
              padding: EdgeInsets.all(8),
            );
          }).toList(),
        ),
      ),
      persistentFooterButtons: <Widget>[
        ElevatedButton(
          child: Text('Scroll to No.55'),
          style: ElevatedButton.styleFrom(primary: Colors.red),
          onPressed: () async {
            await controller.scrollToIndex(
              55,
              preferPosition: AutoScrollPosition.begin
            );
            controller.highlight(55);
          },
        ),
        SizedBox(width: 10),
        ElevatedButton(
          child: Icon(Icons.arrow_upward),
          style: ElevatedButton.styleFrom(primary: Colors.red),
          onPressed: () => controller.animateTo(0, duration: Duration(seconds: 1), curve: Curves.bounceInOut)
        ),
      ],
    );
  }
}
