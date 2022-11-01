import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../model/start_up_data.dart';
import '../services/global.dart';
import '../services/user_info.dart';
import 'package:platform_device_id/platform_device_id.dart';
import '../model/user_model.dart';

class Api{

  // static var url = "https://nabd.sy/api/";
  static var url = "https://nabd.alpha-yabroud.com/api/";


  static Future checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.mobile) {
      return true;
    }else if(result == ConnectivityResult.wifi) {
      return true;
    }else if(result == ConnectivityResult.ethernet){
      return true;
    }else if(result == ConnectivityResult.bluetooth){
      return true;
    }else if(result == ConnectivityResult.none){
      print("No internet connection");
      return false;
    }
  }

  static Future<User> login(String studentId, String password) async {

    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      print(deviceId);
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url + 'student/login'));
    request.body = json.encode({
      "student_id": studentId,
      "password": password,
      "mac_id": deviceId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      // log(data);
      try{
        return User.fromMap(jsonDecode(data));
      }catch(err){
        Global.adminToken = jsonDecode(data)['token'];
        Global.adminId = jsonDecode(data)['id'].toString();
        Global.adminRule = jsonDecode(data)['rule'];
        return User(id: -1, studentId: '-1', phone: '-1', universityId: -1,nationalId: '-1', password: '', email: '', rule: '', days: [], isActive: -1 , name: '', token: '', macId: '');
      }

    }
    else {
      print(response.reasonPhrase);
      UserInfo.clear();
      return User(id: -1, studentId: '-1',nationalId: '-1', phone: '-1', universityId: -1, password: '', email: '', rule: '', days: [], isActive: -1 , name: '', token: '', macId: '');
    }
  }


  static Future<User> autoLogin(String studentId, String password) async {

    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      print(deviceId);
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url + 'student/login-auto'));
    request.body = json.encode({
      "student_id": studentId,
      "password": password,
      "mac_id": deviceId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      //log(data);

      User u = User.fromMap(jsonDecode(data));

      await UserInfo.saveUserInformation(u.studentId,u.nationalId, u.phone, u.email, u.password, u.name,u.token, u.id.toString());
      await UserInfo.loadUserInformation();

      return u;
    }
    else {
      UserInfo.clear();
      return User(id: -1, studentId: '-1',nationalId: '-1', phone: '-1', universityId: -1, password: '', email: '', rule: '', days: [], isActive: -1 , name: '', token: '',macId: '');
    }

  }

  static Future<StartUpData> getStartUpData() async {

    var request = http.Request('GET', Uri.parse(url + 'start-up'));
    print('start');
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonData = await response.stream.bytesToString();
      // print(jsonData);
      return StartUpData.fromMap(jsonDecode(jsonData));
    }
    else {
      print(response.reasonPhrase);
      return StartUpData(stations: [], weekDays: [], beginHour: [], endHour: [], university: []);
    }
  }


  static Future addMeet(String? beginId, String? endId, String? stationId, String weekDaysId, String studentId) async {
    var headers = {
      'Authorization': 'Bearer ${UserInfo.token}',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url + 'meet/'));
    request.body = json.encode({
      "begin_id": beginId,
      "end_id": endId,
      "station_id": stationId,
      "week_days_id": weekDaysId,
      "student_id": studentId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future addAllMeet( String? stationId, String studentId) async {
    var headers = {
      'Authorization': 'Bearer ${UserInfo.token}',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url + 'meet/add-all'));
    request.body = json.encode({
      "station_id": stationId,
      "student_id": studentId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future editAllMeet( String? stationId, String studentId) async {
    var headers = {
      'Authorization': 'Bearer ${UserInfo.token}',
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse(url + 'meet/edit-all'));
    request.body = json.encode({
      "station_id": stationId,
      "student_id": studentId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future editMeet(String? beginId, String? endId, String? stationId, String weekDaysId, String studentId, String meetId ) async {
    var headers = {
      'Authorization': 'Bearer ${UserInfo.token}',
      'Content-Type': 'application/json',
    };
    var request = http.Request('PUT', Uri.parse(url + 'meet'));
    request.body = json.encode({
      "begin_id": beginId,
      "end_id": endId,
      "station_id": stationId,
      "week_days_id": weekDaysId,
      "student_id": studentId,
      "id": meetId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future deleteMeet(String meetId) async {
    var headers = {
      'Authorization': 'Bearer ${UserInfo.token}',
      'Content-Type': 'application/json',
    };
    var request = http.Request('DELETE', Uri.parse(url + 'meet'));
    request.body = json.encode({
      "id": meetId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future changePassword(String password) async {
    var headers = {
      'Authorization': 'Bearer ${UserInfo.token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(url + 'student/change-password'));
    request.body = json.encode({
      "id": UserInfo.id,
      "password": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future checkIn(String studentId) async {
    var headers = {
      'Authorization': 'Bearer '+Global.adminToken,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url + 'meet/check-in'));
    request.body = json.encode({
      "student_id": studentId,
      "admin_id": Global.adminId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }


  static Future deleteAccount() async {
    var headers = {
      'Authorization': 'Bearer ${UserInfo.token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('DELETE', Uri.parse(url + 'student/delete-account'));
    request.body = json.encode({
      "id": UserInfo.id,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }
}