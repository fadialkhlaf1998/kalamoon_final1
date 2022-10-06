// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  User({
    required this.id,
    required this.studentId,
    required this.phone,
    required this.universityId,
    required this.password,
    required this.email,
    required this.name,
    required this.isActive,
    required this.macId,
    required this.rule,
    required this.days,
    required this.token,
  });

  int id;
  String studentId;
  String phone;
  int universityId;
  String password;
  String email;
  String name;
  int isActive;
  String macId;
  String rule;
  List<Day> days;
  String token;

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    studentId: json["student_id"],
    phone: json["phone"],
    universityId: json["university_id"],
    password: json["password"],
    email: json["email"],
    name: json["name"],
    isActive: json["is_active"],
    macId: json["mac_id"] ?? '',
    rule: json["rule"],
    days: json['days'] != null ? List<Day>.from(json["days"].map((x) => Day.fromMap(x))) : <Day>[],
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "student_id": studentId,
    "phone": phone,
    "university_id": universityId,
    "password": password,
    "email": email,
    "name": name,
    "is_active": isActive,
    "mac_id": macId,
    "rule": rule,
    "days": List<dynamic>.from(days.map((x) => x.toMap())),
    "token": token,
  };
}

class Day {
  Day({
    required this.id,
    required this.title,
    required this.arTitle,
    required this.meet,
  });

  int id;
  String title;
  String arTitle;
  List<Meet> meet;

  factory Day.fromMap(Map<String, dynamic> json) => Day(
    id: json["id"],
    title: json["title"],
    arTitle: json["ar_title"],
    meet: json['meet'] != null ? List<Meet>.from(json["meet"].map((x) => Meet.fromMap(x))) : <Meet>[],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "ar_title": arTitle,
    "meet": List<dynamic>.from(meet.map((x) => x.toMap())),
  };
}

class Meet {
  Meet({
    required this.id,
    required this.beginId,
    required this.endId,
    required this.stationId,
    required this.weekDaysId,
    required this.studentId,
    required this.beginHour,
    required this.endHour,
    required this.station,
  });

  int id;
  int beginId;
  int endId;
  int stationId;
  int weekDaysId;
  int studentId;
  String beginHour;
  String endHour;
  List<Station> station;

  factory Meet.fromMap(Map<String, dynamic> json) => Meet(
    id: json["id"],
    beginId: json["begin_id"] ?? -1,
    endId: json["end_id"] ?? -1,
    stationId: json["station_id"],
    weekDaysId: json["week_days_id"],
    studentId: json["student_id"],
    beginHour: json["begin_hour"] ?? '',
    endHour: json["end_hour"] ?? '',
    station: json['station'] != null ? List<Station>.from(json["station"].map((x) => Station.fromMap(x))) : <Station>[],
    // station: List<Station>.from(json["station"].map((x) => Station.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "begin_id": beginId == null ? null : beginId,
    "end_id": endId == null ? null : endId,
    "station_id": stationId,
    "week_days_id": weekDaysId,
    "student_id": studentId,
    "begin_hour": beginHour == null ? null : beginHour,
    "end_hour": endHour == null ? null : endHour,
    "station": List<dynamic>.from(station.map((x) => x.toMap())),
  };
}

class Station {
  Station({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.arrivalTime,
  });

  int id;
  String title;
  String description;
  String image;
  List<ArrivalTime> arrivalTime;

  factory Station.fromMap(Map<String, dynamic> json) => Station(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    arrivalTime: json['arrival_time'] != null ? List<ArrivalTime>.from(json["arrival_time"].map((x) => ArrivalTime.fromMap(x))) : <ArrivalTime>[],
    // arrivalTime: List<ArrivalTime>.from(json["arrival_time"].map((x) => ArrivalTime.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "arrival_time": List<dynamic>.from(arrivalTime.map((x) => x.toMap())),
  };
}

class ArrivalTime {
  ArrivalTime({
    required this.id,
    required this.stationId,
    required this.beginId,
    required this.hour,
    required this.begin,
  });

  int id;
  int stationId;
  int beginId;
  String hour;
  String begin;

  factory ArrivalTime.fromMap(Map<String, dynamic> json) => ArrivalTime(
    id: json["id"],
    stationId: json["station_id"],
    beginId: json["begin_id"],
    hour: json["hour"],
    begin: json["begin"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "station_id": stationId,
    "begin_id": beginId,
    "hour": hour,
    "begin": begin,
  };
}



// // To parse this JSON data, do
// //
// //     final user = userFromMap(jsonString);
//
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// User userFromMap(String str) => User.fromMap(json.decode(str));
//
// String userToMap(User data) => json.encode(data.toMap());
//
// class User {
//   User({
//     required this.id,
//     required this.studentId,
//     required this.phone,
//     required this.universityId,
//     required this.password,
//     required this.email,
//     required this.name,
//     required this.isActive,
//     required this.rule,
//     required this.days,
//     required this.token,
//   });
//
//   int id;
//   String studentId;
//   String phone;
//   int universityId;
//   String password;
//   String email;
//   String name;
//   int isActive;
//   String rule;
//   List<Day> days;
//   String token;
//
//   factory User.fromMap(Map<String, dynamic> json) => User(
//     id: json["id"],
//     studentId: json["student_id"] ?? '-1',
//     phone: json["phone"] ?? "",
//     universityId: json["university_id"] ?? -1,
//     password: json["password"],
//     email: json["email"] ?? "",
//     name: json["name"] ?? "",
//     isActive: json["is_active"] ?? -1,
//     rule: json["rule"],
//     days: json['days'] != null ? List<Day>.from(json["days"].map((x) => Day.fromMap(x))) : <Day>[],
//     token: json["token"] ?? "",
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "student_id": studentId,
//     "phone": phone,
//     "university_id": universityId,
//     "password": password,
//     "email": email,
//     "name": name,
//     "is_active": isActive,
//     "rule": rule,
//     "days": List<dynamic>.from(days.map((x) => x.toMap())),
//     "token": token,
//   };
// }
//
// class Day {
//   Day({
//     required this.id,
//     required this.title,
//     required this.meet,
//   });
//
//   int id;
//   String title;
//   List<dynamic> meet;
//
//   factory Day.fromMap(Map<String, dynamic> json) => Day(
//     id: json["id"],
//     title: json["title"],
//     meet: List<dynamic>.from(json["meet"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "title": title,
//     "meet": List<dynamic>.from(meet.map((x) => x)),
//   };
// }
