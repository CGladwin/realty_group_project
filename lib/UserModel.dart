import 'package:flutter/material.dart';
// import 'User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
