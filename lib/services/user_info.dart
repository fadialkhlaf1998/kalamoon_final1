

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class UserInfo {

  static String studentId = '-1';
  static String phone = '-1';
  static String email = '';
  static String password = '';
  static String name = '';
  static String token = '';
  static String id = '-1';


  List<Day>? days;

  static saveUserInformation(String studentId, String phone, String email,String password, String name,String token, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('studentId', studentId);
    prefs.setString('phone', phone);
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setString('name', name);
    prefs.setString('token', token);
    prefs.setString('id', id);

  }

  static loadUserInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentId = prefs.getString('studentId') ?? '-1';
    phone = prefs.getString('phone') ?? '-1';
    email = prefs.getString('email') ?? "";
    password = prefs.getString('password') ?? "";
    name = prefs.getString('name') ?? "";
    token = prefs.getString('token') ?? "";
    id = prefs.getString('id') ?? "-1";
  }

  static clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('studentId');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('password');
    prefs.remove('name');
    prefs.remove('token');
    prefs.remove('id');
  }



}