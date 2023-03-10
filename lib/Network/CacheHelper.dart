
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences sharedPreferences;
  static init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

  static Future<bool> putboolean({@required String key,@required bool value})
  async{
    return await sharedPreferences.setBool(key, value);
  }

  static bool getboolean({@required String key}){
    return sharedPreferences.getBool(key);
  }

  static Future<bool> savedata({@required String key,
    @required dynamic value})async{
    if(value is String) return await sharedPreferences.setString(key, value);
    if(value is int) return await sharedPreferences.setInt(key, value);
    if(value is bool) return await sharedPreferences.setBool(key, value);

     return await sharedPreferences.setDouble(key, value);
  }

  static  dynamic getdata({@required key}){
    return  sharedPreferences.get(key);
  }

  static Future<bool> removedate({@required String key})async{
    return await sharedPreferences.remove(key);
  }
}