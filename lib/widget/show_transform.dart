import 'package:flutter/material.dart';

class ShowTransform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ? 获取头像
    _getHeader(context) {
      return Transform.translate(
        // * 向上偏移
        offset: Offset(0, -45.0),
        child: Container(
          width: 72.0,
          height: 72.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).cardColor,
                blurRadius: 4.0,
              ),
            ],
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/cat.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        title: Container(
          child: Text('Transform'),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Card(
          margin: EdgeInsets.all(10),
          child: Container(
            height: 160,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _getHeader(context),
                Text(
                  "Flutter 是 Google 开源的 UI 工具包"
                  "帮助开发者通过一套代码库高效构建多平台精美应用"
                  "支持移动、Web、桌面和嵌入式平台。",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
