import 'package:fiora_app_flutter/utils/time.dart';
import 'package:fiora_app_flutter/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageWidget extends StatelessWidget {
  final String id;
  final String content;
  final String type;
  final String name;
  final String avatar;
  final String creator;
  final DateTime createTime;

  MessageWidget({
    @required this.id,
    @required this.content,
    @required this.type,
    @required this.name,
    @required this.avatar,
    @required this.creator,
    @required this.createTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(22),
        vertical: ScreenUtil().setHeight(22),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Avatar(
            url: "https:" + avatar,
            height: ScreenUtil().setHeight(110),
            width: ScreenUtil().setWidth(110),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('$name  ${Time.formatTime(createTime)}'),
                Container(
                  // width: ScreenUtil().setWidth(500),
                  constraints: BoxConstraints(
                    minWidth: ScreenUtil().setWidth(20),
                    maxWidth: ScreenUtil().setWidth(500),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color.fromRGBO(22, 44, 23, 0.6),
                  ),
                  child: Text(
                    content,
                    style: TextStyle(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
