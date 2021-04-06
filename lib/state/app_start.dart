import 'package:flutter/material.dart';

class AppState extends ChangeNotifier{

  int _menuIndex = 3;
  int get menuIndex => _menuIndex;
  void changeMenuIndex(int index){
    _menuIndex = index;
    notifyListeners();
  }

  // product detail page
  bool _reflectiveMode = false;
  bool get reflectiveMode => _reflectiveMode;
  void toggleReflectiveMode(){
    _reflectiveMode = !_reflectiveMode;
    notifyListeners();
  }

  void setReflectiveMode(bool status){
    _reflectiveMode = status;
    notifyListeners();
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void setCurrentIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }

  void reset360View(){
    _currentIndex = 0;
    _reflectiveMode = false;
    notifyListeners();
  }

}
