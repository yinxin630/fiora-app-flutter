import 'package:flutter/foundation.dart';

import 'message.dart';

class LinkmanItem {
  final String sId;
  final String type;
  final int unread;
  final String name;
  final String avatar;
  final String creator;
  final DateTime createTime;
  final Message message;

  LinkmanItem({
    @required this.sId,
    @required this.type,
    @required this.unread,
    @required this.name,
    @required this.avatar,
    @required this.creator,
    @required this.createTime,
    @required this.message,
  });
}