import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/fetch.dart' as Fetch;
import '../models/socket_exception.dart';

class Auth with ChangeNotifier {
  bool _isAdmin;
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
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
      print(resData);
      _token = resData['token'];
      _userId = resData['_id'];
      _isAdmin = resData['isAdmin'];
      _expiryDate = DateTime.now().add(Duration(
        days: 7,
      ));
      // 过期时间
      // print(_expiryDate);
      _autoLogout();
      notifyListeners();
      final perfs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'isAdmin': _isAdmin,
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
    // final res = await Fetch.fetch(
    //     urlSegment,
    //     {'username': userName, 'password': password},
    //   );
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _isAdmin = extractedUserData['isAdmin'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

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
