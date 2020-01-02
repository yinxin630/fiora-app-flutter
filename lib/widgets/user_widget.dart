import 'package:fiora_app_flutter/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserWidget extends StatelessWidget {
  // 个人设置面板 先判断用户是否登录，登录拿取本地的 Avatar

  @override
  Widget build(BuildContext context) {
    // print(Provider.of<Auth>(context, listen: false).frienditem);
    // print(Provider.of<Auth>(context, listen: false).groupitem);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
      child: Text('123333'),
    );
  }
}