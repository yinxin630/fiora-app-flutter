import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../models/socket_exception.dart';

enum AuthMode { Signup, Login }

class AuthWidget extends StatefulWidget {
  @override
  _AuthAuthWidgetState createState() => _AuthAuthWidgetState();
}

class _AuthAuthWidgetState extends State<AuthWidget>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'username': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('出错了!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  // 表单提交 注册 or 登录
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(_authData['username'], _authData['password']);
      Navigator.of(context).pop();
      setState(() {
        _isLoading = false;
      });
    } on SocketException catch (e) {
      Navigator.of(context).pop();
      _showErrorDialog(e.toString());
    } catch (e) {
      print(e);
      const errorMessage = '未知错误，请稍后再试.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(100),
            right: ScreenUtil().setWidth(100),
          ),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: '用户名'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return '无效的用户名!';
                  }
                },
                onSaved: (value) {
                  _authData['username'] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '密码'),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return '密码不能为空!';
                  }
                },
                onSaved: (value) {
                  _authData['password'] = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      child: Text(_authMode == AuthMode.Login ? '登录' : '注册'),
                      onPressed: _submit,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                    ),
              // FlatButton(
              //   child: Text(
              //       '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
              //   // onPressed: _switchAuthMode,
              //   padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
              //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //   textColor: Theme.of(context).primaryColor,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
