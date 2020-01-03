import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/fetch.dart' as Fetch;
import '../models/socket_exception.dart';

class Auth with ChangeNotifier {
  String _userId; // 用户ID
  DateTime _expiryDate; // 过期时间
  Timer _authTimer; // 定时器
  String _token; // token
  String _avatar; // token
  String _username; // token
  String _tag; // token
  bool _isAdmin; // 判断是否为管理员

  List _frienditem = [];
  List _groupitem = [];

  bool get isAuth {
    return token != null;
  }

  dynamic get avatar {
    return _avatar;
  }

  dynamic get frienditem {
    return [..._frienditem];
  }

  dynamic get groupitem {
    return [..._groupitem];
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
    String urlSegment,
    String userName,
    String password,
  ) async {
    try {
      final res = await Fetch.fetch(
        urlSegment,
        {'username': userName, 'password': password},
      );
      print(res);
      if (res[0] != null) {
        throw SocketException(res[0]);
      }
      final resData = res[1];
      setValue(
        friends: resData['friends'],
        groups: resData['groups'],
        token: resData['token'],
        userId: resData['_id'],
        isAdmin: resData['isAdmin'],
        tag: resData['tag'],
        username: resData['username'],
        avatar: resData['avatar'],
        expiryDate: DateTime.now().add(Duration(
          days: 7,
        )),
      );
      // 旧代码
      // _frienditem = resData['friends'];
      // _groupitem = resData['groups'];
      // _token = resData['token'];
      // _userId = resData['_id'];
      // _isAdmin = resData['isAdmin'];
      // _tag = resData['tag'];
      // _username = resData['username'];
      // _avatar = resData['avatar'];
      // _expiryDate = DateTime.now().add(Duration(
      //   days: 7,
      // ));
      // 过期时间
      // print(_expiryDate);
      _autoLogout();
      notifyListeners();
      final perfs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'isAdmin': _isAdmin,
        'tag': _tag,
        'username': _username,
        'avatar': _avatar,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      perfs.setString('userData', userData);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(String userName, String password) async {
    return _authenticate('register', userName, password);
  }

  Future<void> login(String userName, String password) async {
    return _authenticate('login', userName, password);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    // 自动登录 - 保留
    final res = await Fetch.fetch(
      'loginByToken',
      {'token': extractedUserData['token']},
    );
    if (res[0] != null) {
      throw SocketException(res[0]);
    }
    final resData = res[1];
    // logout();
    setValue(
      friends: resData['friends'],
      groups: resData['groups'],
      token: extractedUserData['token'],
      userId: extractedUserData['userId'],
      isAdmin: extractedUserData['isAdmin'],
      tag: extractedUserData['tag'],
      username: extractedUserData['username'],
      avatar: extractedUserData['avatar'],
      expiryDate: expiryDate,
    );
    // 旧代码
    // _frienditem = resData['friends'];
    // _groupitem = resData['groups'];
    // _token = extractedUserData['token'];
    // _userId = extractedUserData['userId'];
    // _isAdmin = extractedUserData['isAdmin'];
    // _tag = extractedUserData['tag'];
    // _username = extractedUserData['username'];
    // _avatar = extractedUserData['avatar'];
    // _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  void setValue({
    friends,
    groups,
    token,
    userId,
    isAdmin,
    tag,
    username,
    avatar,
    expiryDate,
  }) {
    _frienditem = friends;
    _groupitem = groups;
    _token = token;
    _userId = userId;
    _isAdmin = isAdmin;
    _tag = tag;
    _username = username;
    _avatar = "https:" + avatar;
    _expiryDate = expiryDate;
  }

  // 登出
  Future<void> logout() async {
    _token = null;
    _userId = null;
    _isAdmin = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    // prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    // print(timeToExpiry);
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
