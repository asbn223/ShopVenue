import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopvenue_app/expection/http_expection.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

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
}
