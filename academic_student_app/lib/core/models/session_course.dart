// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SessionCourse {
  final int id;
  final String name;
  final String code;
  final String description;
  final List schedule;
  final String dateFrom;
  final String dateTo;
  final bool? isFavorite;
  SessionCourse(
      {required this.id,
      required this.name,
      required this.code,
      required this.description,
      required this.schedule,
      required this.dateFrom,
      required this.dateTo,
      this.isFavorite});

  SessionCourse copyWith(
      {int? id,
      String? name,
      String? code,
      String? description,
      List? schedule,
      String? dateFrom,
      String? dateTo,
      bool? isFavorite}) {
    return SessionCourse(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        description: description ?? this.description,
        schedule: schedule ?? this.schedule,
        dateFrom: dateFrom ?? this.dateFrom,
        dateTo: dateTo ?? this.dateTo,
        isFavorite: isFavorite ?? this.isFavorite);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'schedule': schedule,
      'date_from': dateFrom,
      'date_to': dateTo,
    };
  }

  factory SessionCourse.fromMap(Map<String, dynamic> map) {
    return SessionCourse(
        id: map['id'] as int,
        name: map['name'] as String,
        code: map['code'] as String,
        description: map['description'] as String,
        schedule: List.from((map['schedule'] as List)),
        dateFrom: map['date_from'] as String,
        dateTo: map['date_to'] as String,
        isFavorite: map["is_favorite"]);
  }

  String toJson() => json.encode(toMap());

  factory SessionCourse.fromJson(String source) =>
      SessionCourse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SessionCourse(id: $id, name: $name, code: $code, description: $description, schedule: $schedule, dateFrom: $dateFrom, dateTo: $dateTo)';
  }

  @override
  bool operator ==(covariant SessionCourse other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.code == code &&
        other.description == description &&
        listEquals(other.schedule, schedule) &&
        other.dateFrom == dateFrom &&
        other.dateTo == dateTo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        code.hashCode ^
        description.hashCode ^
        schedule.hashCode ^
        dateFrom.hashCode ^
        dateTo.hashCode;
  }
}

List<SessionCourse> sessionCoursesFromListMap(List source) {
  List<SessionCourse> courses = [];
  for (var element in source) {
    courses.add(SessionCourse.fromMap(element));
  }
  return courses;
}
