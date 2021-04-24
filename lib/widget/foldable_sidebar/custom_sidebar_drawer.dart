import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSidebarDrawer extends StatelessWidget {
  final Function drawerClose;
  const CustomSidebarDrawer({Key key, this.drawerClose}) : super(key: key);

  Divider widgetDividerBuild() {
    return Divider(
      height: 1.h,
      color: Colors.grey,
    );
  }

  ListTile widgetListTileBuild(title, icon) {
    return ListTile(
      title: Text('$title'),
      leading: icon,
      trailing: Icon(Icons.sort),
      onTap: () => debugPrint('Tapped $title'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth * 0.6,
      height: ScreenUtil().screenHeight,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 100.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cat.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          widgetListTileBuild('Profile', Icon(Icons.person)),
          widgetDividerBuild(),
          widgetListTileBuild('Settings', Icon(Icons.settings)),
          widgetDividerBuild(),
          widgetListTileBuild('Log Out', Icon(Icons.exit_to_app)),
        ],
      ),
    );
  }
}
