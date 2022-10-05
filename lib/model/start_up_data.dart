// To parse this JSON data, do
//
//     final startUpData = startUpDataFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StartUpData startUpDataFromMap(String str) => StartUpData.fromMap(json.decode(str));

String startUpDataToMap(StartUpData data) => json.encode(data.toMap());

class StartUpData {
  StartUpData({
    required this.stations,
    required this.weekDays,
    required this.beginHour,
    required this.endHour,
    required this.university,
  });

  List<Station> stations;
  List<WeekDay> weekDays;
  List<Hour> beginHour;
  List<Hour> endHour;
  List<University> university;

  factory StartUpData.fromMap(Map<String, dynamic> json) => StartUpData(
    stations: List<Station>.from(json["stations"].map((x) => Station.fromMap(x))),
    weekDays: List<WeekDay>.from(json["week_days"].map((x) => WeekDay.fromMap(x))),
    beginHour: List<Hour>.from(json["begin_hour"].map((x) => Hour.fromMap(x))),
    endHour: List<Hour>.from(json["end_hour"].map((x) => Hour.fromMap(x))),
    university: List<University>.from(json["university"].map((x) => University.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "stations": List<dynamic>.from(stations.map((x) => x.toMap())),
    "week_days": List<dynamic>.from(weekDays.map((x) => x.toMap())),
    "begin_hour": List<dynamic>.from(beginHour.map((x) => x.toMap())),
    "end_hour": List<dynamic>.from(endHour.map((x) => x.toMap())),
    "university": List<dynamic>.from(university.map((x) => x.toMap())),
  };
}

class Hour {
  Hour({
    required this.id,
    required this.hour,
  });

  int id;
  String hour;

  factory Hour.fromMap(Map<String, dynamic> json) => Hour(
    id: json["id"],
    hour: json["hour"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "hour": hour,
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
    arrivalTime: List<ArrivalTime>.from(json["arrival_time"].map((x) => ArrivalTime.fromMap(x))),
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

class University {
  University({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory University.fromMap(Map<String, dynamic> json) => University(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
  };
}

class WeekDay {
  WeekDay({
    required this.id,
    required this.title,
    required this.ar_title,
  });

  int id;
  String title;
  String ar_title;

  factory WeekDay.fromMap(Map<String, dynamic> json) => WeekDay(
    id: json["id"],
    title: json["title"],
    ar_title: json["ar_title"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "ar_title": ar_title,
  };
}

