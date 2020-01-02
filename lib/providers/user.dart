import 'package:flutter/foundation.dart';

class UserItem {
  final String sId;
  final String avatar;
  final String username;
  final String tag;
  // 考虑再三， 将 friends 和 groups 移出 UserItem 包装
  // final List<FriendItem> friends;
  // final List<GroupsItem> groups;
  final bool isAdmin;

  UserItem({
    @required this.sId,
    @required this.avatar,
    @required this.username,
    this.tag,
    // this.friends,
    // this.groups,
    @required this.isAdmin,
  });
}

class User with ChangeNotifier {
  List<UserItem> _items = [];

  List<UserItem> get items {
    return [..._items];
  }

  int get itemCount {
    return _items.length;
  }

  // 查找用户
  UserItem findById(String id) {
    return _items.firstWhere((item) => item.sId == id);
  }

  void addItem(
    UserItem user,
  ) {
    final userIndex = _items.indexWhere((item) => item.sId == user.sId);

    if (userIndex >= 0) {
      _items[userIndex] = user;
    } else {
      _items.add(
        UserItem(
          sId: user.sId,
          avatar: user.avatar,
          username: user.username,
          tag: user.tag,
          isAdmin: user.isAdmin,
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

// {
//   "_id": "5d53f133a76e426ce888eeab",
//   "avatar": "//cdn.suisuijiang.com/Avatar/5d53f133a76e426ce888eeab_1567079280473",
//   "username": "q111",
//   "tag": "勇太",
//   "groups": [
//     {
//       "_id": "5adacdcfa109ce59da3e83d3",
//       "name": "fiora",
//       "avatar": "//cdn.suisuijiang.com/GroupAvatar/5adad39555703565e7903f78_1546952226984",
//       "createTime": "2018-04-21T05:36:15.876Z",
//       "creator": "5ca09cde11f8580ffc4d13dc"
//     },
//     {
//       "_id": "5bd6c2bf5d03f62414b78247",
//       "name": "开车群",
//       "avatar": "//cdn.suisuijiang.com/fiora/avatar/13.jpg",
//       "creator": "5bd6be175d03f62414b781b3",
//       "createTime": "2018-10-29T08:20:15.272Z"
//     }
//   ],
//   "friends": [
//     {
//       "_id": "5e0d9310a1f380078e847bda",
//       "from": "5d53f133a76e426ce888eeab",
//       "to": {
//         "_id": "5adad39555703565e7903f78",
//         "username": "碎碎酱",
//         "avatar": "//cdn.suisuijiang.com/Avatar/5adad39555703565e7903f78_1545640960633"
//       },
//       "createTime": "2020-01-02T06:52:00.665Z",
//       "__v": 0
//     }
//   ],
//   "isAdmin": false
// }
