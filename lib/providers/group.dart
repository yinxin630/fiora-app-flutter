import 'package:flutter/foundation.dart';

import '../models/groups.dart';

// class GroupItem {
//   final String sId;
//   final String name;
//   final String avatar;
//   final DateTime createTime;
//   final String creator;

//   GroupItem({
//     @required this.sId,
//     @required this.name,
//     @required this.avatar,
//     @required this.createTime,
//     @required this.creator,
//   });
// }


class Friends with ChangeNotifier {
  List<GroupItem> _items = [];

  List<GroupItem> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  // 查找好友
  GroupItem findById(String id) {
    return _items.firstWhere((item) => item.sId == id);
  }

  void addItem(
    GroupItem user,
  ) {
    final userIndex = _items.indexWhere((item) => item.sId == user.sId);

    if (userIndex >= 0) {
      _items[userIndex] = user;
    } else {
      _items.add(
        GroupItem(
          sId: user.sId,
          name: user.name,
          avatar: user.avatar,
          creator: user.creator,
        ),
      );
    }
    print(_items);
    notifyListeners();
  }

  void removeItem(String sId) {
    _items.removeWhere((item) => item.sId == sId);
    notifyListeners();
  }

  void clear() {
    _items = [];
    notifyListeners();
  }
}