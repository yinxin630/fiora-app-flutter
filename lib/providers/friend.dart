import 'package:flutter/foundation.dart';

import '../models/friends.dart';

// class To {
//   final String sId;
//   final String username;
//   final String avatar;

//   To({
//     @required this.sId,
//     @required this.username,
//     @required this.avatar,
//   });
// }

// class FriendItem {
//   final String sId;
//   final String from;
//   final To to;

//   FriendItem({
//     @required this.sId,
//     @required this.from,
//     @required this.to,
//   });
// }

class Friends with ChangeNotifier {
  List<FriendItem> _items = [];

  List<FriendItem> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  // 查找好友
  FriendItem findById(String id) {
    return _items.firstWhere((item) => item.sId == id);
  }

  void addItem(
    FriendItem user,
  ) {
    final userIndex = _items.indexWhere((item) => item.sId == user.sId);

    if (userIndex >= 0) {
      _items[userIndex] = user;
    } else {
      _items.add(
        FriendItem(
          sId: user.sId,
          from: user.from,
          to: To(
            sId: user.to.sId,
            username: user.to.username,
            avatar: user.to.avatar,
          ),
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
