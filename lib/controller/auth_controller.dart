import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  // Add authentication logic here
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}