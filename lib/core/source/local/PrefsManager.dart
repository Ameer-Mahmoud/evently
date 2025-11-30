import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager{
  static late SharedPreferences sharedPreferences;
  static int()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setTheme(ThemeMode mode){
    sharedPreferences.setString("theme",mode==ThemeMode.dark?"dark": "light");
  }
  static ThemeMode getTheme(){
    String saved = sharedPreferences.getString("theme")??"light";
    if(saved == "dark"){
      return ThemeMode.dark;
    }else{
      return ThemeMode.light;
    }
  }
}