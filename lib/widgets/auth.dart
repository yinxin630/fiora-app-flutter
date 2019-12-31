import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../fetch.dart' as Fetch;

enum AuthMode { Signup, Login }

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
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
        title: Text('An Error Occurred!'),
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

    var result = await Fetch.fetch(
      'login',
      {'username': _authData['username'], 'password': _authData['password']},
    );
    print(result);

    setState(() {
      _isLoading = false;
    });
    if (result[0] == null) return Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("提示"),
          content:
              new Text(result[0] != null ? result[0] : result[1].toString()),
        );
      },
    );
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
