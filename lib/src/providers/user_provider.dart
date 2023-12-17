import 'package:fakebook/src/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  void updateUse(User newData) {
    user = newData;
    notifyListeners();
  }
}
