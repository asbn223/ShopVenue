import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopvenue_app/expection/http_expection.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isLoggedIn {
    return _token != null;
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

  Future<void> _auth(String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDTBNQur5VTQXSP0i9p9_xSlUvxzuDqXKA';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email.trim(),
          'password': password,
          'returnSecureToken': true
        }),
      );
      final responseMessage = json.decode(response.body);
      if (responseMessage['error'] != null) {
        throw HttpExpection(responseMessage['error']['message']);
      }
      _token = responseMessage['idToken'];
      _userId = responseMessage['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseMessage['expiresIn']),
        ),
      );
      autoLogOut();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> signUp(String email, String password) async {
    return _auth(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _auth(email, password, 'signInWithPassword');
  }

  void logOut() {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void autoLogOut() {
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    final timeToExpire = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire), logOut);
  }
}
