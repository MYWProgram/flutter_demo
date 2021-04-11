import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginCheck'),
        elevation: 0,
        backgroundColor: Colors.red,
      ),
      body: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  Widget _buildForm() {
    return Form(
      // * 设置 globalKey 用于后面获取 FormState
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: false,
            keyboardType: TextInputType.number,
            // * 自定义键盘回车键样式
            textInputAction: TextInputAction.next,
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: '用户名',
              hintText: '您的用户名',
              icon: Icon(Icons.person),
            ),
            validator: (value) {
              return value.trim().length > 0 ? null : '用户名不能为空';
            },
          ),
          TextFormField(
            autofocus: false,
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: '密码',
              hintText: '您的登录密码',
              icon: Icon(Icons.lock),
            ),
            validator: (value) {
              return value.trim().length > 5 ? null : '密码不能少于6位数';
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 28.0.h),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text('登 录'),
                    onPressed: () {
                      // * 通过 _formKey.currentState 获取 FormState
                      if ((_formKey.currentState as FormState).validate()) {
                        print(_formKey.currentState);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/images/cat.jpg',
              )
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                left: 30.0.w,
                right: 30.0.w,
              ),
              color: Colors.white,
              child: Container(
                child: _buildForm(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
