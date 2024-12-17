import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum ValueType { int, string, bool, double, map, list }

class CacheHelper {
  static CacheHelper? instance;
  late final SharedPreferences _sharedPreferences;
  //بخليه برايفت عشان مقدرش اعمل اوبجكت من الكلاس دا من برا
  CacheHelper._internal();
  // بعمل اوبجكت من الكلاس دا من جوا الكلاس من خلال اني بدي البرايفت كونستراكتور للانستانس اللي اتعمل فوق دا
  // وبرن الميثود كلها فالمين بالتالي هيكريت الاوبجكت اول ما بستخدم الابلكيشن ومش هيتكريت اي اوبجكت غير اللي عملته
  static init() async {
    if (instance == null) {
      instance = CacheHelper._internal();
      instance!._sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  Future<void> setData(String key, {dynamic value}) async {
    if (value is String) {
      _sharedPreferences.setString(key, value);
    } else if (value is bool) {
      _sharedPreferences.setBool(key, value);
    } else if (value is int) {
      _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      _sharedPreferences.setDouble(key, value);
    } else if (value is List<String>) {
      _sharedPreferences.setStringList(key, value);
    } else if (value is Map) {
      String json = jsonEncode(value);
      _sharedPreferences.setString(key, json);
    } else {
      throw TypeError();
    }
  }

  dynamic getData({required String key, required ValueType valueType}) {
    switch (valueType) {
      case ValueType.string:
        return _sharedPreferences.getString(key) ?? "";
      case ValueType.list:
        return _sharedPreferences.getStringList(key) ?? [];
      case ValueType.int:
        return _sharedPreferences.getInt(key) ?? 0;
      case ValueType.double:
        return _sharedPreferences.getDouble(key) ?? 0.0;
      case ValueType.bool:
        return _sharedPreferences.getBool(key) ?? false;
      case ValueType.map:
        String? value = _sharedPreferences.getString(key);
        Map<String, dynamic> data = value != null ? jsonDecode(value) : {};
        return data;
      // default:
      //   return "";
    }
  }

  void clear() {
    _sharedPreferences.clear();
  }

  Future<bool> sigOut({required String key}) async {
    return await _sharedPreferences.remove(key);
  }
}
//CacheHelper.instance!.getData(key: AppConstKey().user , valueType: ValueType.map)

// import 'package:shared_preferences/shared_preferences.dart';

// class CacheHelper {
//   static late SharedPreferences sharedPreferences;
//   static init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }

//   static dynamic getData({
//     required String key,
//   }) {
//     return sharedPreferences.get(key);
//   }

//   static Future<bool> saveData({
//     required String key,
//     required dynamic value,
//   }) async {
//     if (value is String) {
//       return await sharedPreferences.setString(key, value);
//     }
//     if (value is List<String>) {
//       return await sharedPreferences.setStringList(key, value);
//     }
//     if (value is int) {
//       return await sharedPreferences.setInt(key, value);
//     }
//     if (value is bool) {
//       return await sharedPreferences.setBool(key, value);
//     }

//     return await sharedPreferences.setDouble(key, value);
//   }

//   static Future<bool> removeToken({
//     required String key,
//   }) async {
//     return await sharedPreferences.remove(key);
//   }
// }
