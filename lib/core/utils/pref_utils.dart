//ignore: unused_import
import 'dart:convert';

import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/filter/filter_model.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  static void clearPreferencesData() async {
    _sharedPreferences!.clear();
    await FirebaseServices.handleLogOut();
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  static Future<void> setId(String value) {
    return _sharedPreferences!.setString('id', value);
  }

  static String getId() {
    return _sharedPreferences?.getString('id') ?? '';
  }

  static Future<void> setUserName(String value) {
    return _sharedPreferences!.setString('userName', value);
  }

  static String getUserName() {
    return _sharedPreferences?.getString('userName') ?? '';
  }

  static Future<void> setGender(String value) {
    return _sharedPreferences!.setString('gender', value);
  }

  static String getUserGender() {
    return _sharedPreferences?.getString('gender') ?? '';
  }

  static Future<void> saveFilter(PreferenceFilter filter) async {
    await _sharedPreferences?.setString('filter', jsonEncode(filter.toJson()));
  }

  static int getOtp() {
    return _sharedPreferences?.getInt('otp') ?? 0;
  }

  static Future<void> saveOtp(int otp) async {
    await _sharedPreferences?.setInt('otp', otp);
  }

  static Future<void> setLang(String value) {
    return _sharedPreferences!.setString('lang', value);
  }

  static String getLang() {
    return _sharedPreferences?.getString('lang') ?? 'en';
  }

  static Future<PreferenceFilter?> getFilter() async {
    final jsonString = _sharedPreferences?.getString('filter');
    if (jsonString == null) return null;
    final jsonMap = jsonDecode(jsonString);
    return PreferenceFilter.fromJson(jsonMap);
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }
}
