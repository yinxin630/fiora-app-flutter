import 'package:fiora_app_flutter/providers/auth.dart';
import 'package:fiora_app_flutter/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class User extends StatelessWidget {
  static const routeName = '/user';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('123123'),
      ),
      body: Consumer<Auth>(
        builder: (ctx, authData, child) => ListView.builder(
          itemCount: authData.getMessageItem(id).length,
          itemBuilder: (ctx, i) => MessageWidget(
            id: authData.getMessageItem(id)[i].sId,
            content: authData.getMessageItem(id)[i].content,
            type: authData.getMessageItem(id)[i].type,
            name: authData.getMessageItem(id)[i].from.username,
            avatar: authData.getMessageItem(id)[i].from.avatar,
            creator: authData.getMessageItem(id)[i].from.sId,
            createTime: DateTime.parse(authData.getMessageItem(id)[i].createTime),
          ),
        ),
      ),
    );
  }
}
