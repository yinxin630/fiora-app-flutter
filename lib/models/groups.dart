import 'package:flutter/foundation.dart';

class GroupItem {
  final String sId;
  final String name;
  final String avatar;
  final String creator;

  GroupItem({
    @required this.sId,
    @required this.name,
    @required this.avatar,
    @required this.creator,
  });
}