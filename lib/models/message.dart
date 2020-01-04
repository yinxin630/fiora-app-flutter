import 'package:flutter/foundation.dart';

class Message {
  String type;
  String content;
  String sId;
  FromUser from;
  String createTime;

  Message({
    @required this.type,
    @required this.content,
    @required this.sId,
    @required this.from,
    @required this.createTime,
  });
}

class FromUser {
  String tag;
  String sId;
  String username;
  String avatar;

  FromUser({
    @required this.tag,
    @required this.sId,
    @required this.username,
    @required this.avatar,
  });
}
