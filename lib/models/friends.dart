import 'package:flutter/foundation.dart';

class To {
  final String sId;
  final String username;
  final String avatar;

  To({
    @required this.sId,
    @required this.username,
    @required this.avatar,
  });
}

class FriendItem {
  final String sId;
  final String from;
  final To to;

  FriendItem({
    @required this.sId,
    @required this.from,
    @required this.to,
  });
}