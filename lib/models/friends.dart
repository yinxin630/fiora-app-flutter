import 'package:fiora_app_flutter/utils/util.dart';
import 'package:flutter/foundation.dart';

class FriendItem {
  final String sId;
  final String name;
  final String avatar;
  final DateTime createTime;

  FriendItem({
    @required this.sId,
    @required this.name,
    @required this.avatar,
    @required this.createTime,
  });

  factory FriendItem.fromJson(Map<String, dynamic> json) {
    return FriendItem(
      sId: Util.getFriendId(json['from'], json['to']['_id']),
      name: json['to']['username'],
      avatar: json['to']['avatar'],
      createTime: DateTime.parse(json['createTime']),
    );
  }
}