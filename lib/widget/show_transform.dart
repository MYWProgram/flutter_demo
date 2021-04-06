import 'package:flutter/material.dart';

class ShowTransform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ? 获取头像
    _getHeader(context) {
      return Transform.translate(
        // * 向上偏移
        offset: Offset(0, -36.0),
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
        title: Container(
          child: Text('Transform'),
        ),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Card(
          child: Container(
            child: Column(
              children: <Widget>[
                _getHeader(context),
                Text(
                  "Flutter is Google's portable UI toolkit for crafting "
                  "beautiful, natively compiled applications for mobile, "
                  "web, and desktop from a single codebase. ",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 3,
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            height: 150,
            padding: EdgeInsets.all(10),
          ),
          margin: EdgeInsets.all(10),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
