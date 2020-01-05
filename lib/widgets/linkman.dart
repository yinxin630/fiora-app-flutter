import 'package:fiora_app_flutter/screens/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'avatar.dart';

class Linkman extends StatelessWidget {
  final String id;
  final String avatar;
  final String name;
  final String massage;
  final DateTime time;

  Linkman({
    @required this.id,
    @required this.avatar,
    @required this.name,
    @required this.massage,
    @required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('提示'),
            content: Text('确定要移除此会话吗？'),
            actions: <Widget>[
              FlatButton(
                child: Text('取消'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('确定'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        // Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(User.routeName);
        },
        child: Hero(
          tag: '5adad39555703565e7903f785d53f133a76e426ce888eeab',
          child: Card(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Avatar(
                    url: "https:" + avatar,
                    width: ScreenUtil().setWidth(110),
                    height: ScreenUtil().setHeight(110),
                  ),
                ),
                title: Text(name),
                subtitle: Text(massage),
                trailing: Text(time.toString()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
