import 'package:fiora_app_flutter/providers/auth.dart';
import 'package:fiora_app_flutter/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class User extends StatelessWidget {
  static const routeName = '/user';

  @override
  Widget build(BuildContext context) {
    // authData.getMessageItem('5adad39555703565e7903f785d53f133a76e426ce888eeab')
    return Scaffold(
      appBar: AppBar(
        title: Text('123123'),
      ),
      body: Consumer<Auth>(
        builder: (ctx, authData, child) => ListView.builder(
          itemCount: authData
              .getMessageItem(
                  '5adad39555703565e7903f785d53f133a76e426ce888eeab')
              .length,
          itemBuilder: (ctx, i) => MessageWidget(
              content: authData
                  .getMessageItem(
                      '5adad39555703565e7903f785d53f133a76e426ce888eeab')[i]
                  .content),
        ),
      ),
    );
  }
}
