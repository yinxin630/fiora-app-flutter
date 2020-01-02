import 'package:fiora_app_flutter/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class User extends StatelessWidget {
  static const routeName = '/user';

  @override
  Widget build(BuildContext context) {
    print(Provider.of<Auth>(context, listen: false).frienditem);
    print(Provider.of<Auth>(context, listen: false).groupitem);
    return Text("text...................");
  }
}
