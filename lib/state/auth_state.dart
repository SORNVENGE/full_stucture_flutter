import 'package:flutter/material.dart';

class Auth extends ChangeNotifier{
  String _currentForm = 'signup';
  String get currentForm => _currentForm;
  void changeForm(String form){
    _currentForm = form;
    notifyListeners();
  }

}