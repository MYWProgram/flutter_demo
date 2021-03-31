import 'package:flutter/material.dart';

class ControllerDemoPage extends StatelessWidget {
  final TextEditingController controller =
      new TextEditingController(text: '初始文本');

  Widget expandedInkWell(context) {
    return Expanded(
      child: InkWell(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(
      'padding: ${MediaQuery.of(context).padding}, viewInsets.bottom: ${MediaQuery.of(context).viewInsets.bottom}',
    );
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text(
            'ControllerDemoPage',
            style: TextStyle(color: Colors.white),
          ),
          alignment: Alignment.center,
        ),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[
          expandedInkWell(context),
          Container(
            margin: EdgeInsets.all(10),
            child: Center(
              child: TextField(
                controller: controller,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          expandedInkWell(context),
          FloatingActionButton(
            child: Text('Value'),
            onPressed: () => print(controller.text),
          ),
        ],
      ),
    );
  }
}
