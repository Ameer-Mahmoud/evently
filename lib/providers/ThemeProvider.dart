import 'package:evently_c16/core/source/local/PrefsManager.dart';
import 'package:flutter/material.dart';
// observable
// publisher
class ThemeProvider extends ChangeNotifier{
  // info
  // function can change info
  ThemeMode mode = ThemeMode.light;
  init(){
    mode = PrefsManager.getTheme();
  }
  changeTheme(ThemeMode newMode){
    mode = newMode;
    notifyListeners();
  }
}