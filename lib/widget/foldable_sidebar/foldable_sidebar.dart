import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import './custom_sidebar_drawer.dart';

class FoldableSidebar extends StatefulWidget {
  @override
  _FoldableSidebarState createState() => _FoldableSidebarState();
}

class _FoldableSidebarState extends State<FoldableSidebar> {
  FSBStatus _fsbStatus;

  Container welcomeScreen() {
    return Container(
      color: Colors.black.withAlpha(50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to FoldableSidebar',
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              'Click on FAB button to open sidebar',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FoldableSidebar'),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: FoldableSidebarBuilder(
        drawerBackgroundColor: Colors.cyan[100],
        drawer: CustomSidebarDrawer(
          drawerClose: () {
            setState(() {
              _fsbStatus = FSBStatus.FSB_CLOSE;
            });
          },
        ),
        screenContents: welcomeScreen(),
        status: _fsbStatus,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        child: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            _fsbStatus = _fsbStatus == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
          });
        },
      ),
    );
  }
}
