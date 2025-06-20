// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:academic_student/core/models/request_status.dart';
import 'package:academic_student/core/models/request_type.dart';

class RequestModel {
  final int id;
  final String title;
  final String courseId;
  final RequestType type;
  final RequestStatus status;
  final String deliveryDate;
  final List studentAttachments;
  final String studentNotes;
  final List instructorAttachments;
  final String instructorNotes;
  RequestModel({
    required this.id,
    required this.title,
    required this.courseId,
    required this.type,
    required this.status,
    required this.deliveryDate,
    required this.studentAttachments,
    required this.studentNotes,
    required this.instructorAttachments,
    required this.instructorNotes,
  });

  RequestModel copyWith({
    int? id,
    String? title,
    String? courseId,
    RequestType? type,
    RequestStatus? status,
    String? deliveryDate,
    List? studentAttachments,
    String? studentNotes,
    List? instructorAttachments,
    String? instructorNotes,
  }) {
    return RequestModel(
      id: id ?? this.id,
      title: title ?? this.title,
      courseId: courseId ?? this.courseId,
      type: type ?? this.type,
      status: status ?? this.status,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      studentAttachments: studentAttachments ?? this.studentAttachments,
      studentNotes: studentNotes ?? this.studentNotes,
      instructorAttachments: instructorAttachments ?? this.instructorAttachments,
      instructorNotes: instructorNotes ?? this.instructorNotes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'course_id': courseId,
      'type': type.toMap(),
      'status': status.toMap(),
      'delivery_date': deliveryDate,
      'student_attachments': studentAttachments,
      'student_notes': studentNotes,
      'instructor_attachments': instructorAttachments,
      'instructor_notes': instructorNotes,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'] as int,
      title: map['title'] as String,
      courseId: map['course_id'] != null ? map['course_id'] as String : '-1',
      type: RequestType.fromMap(map['type'] as Map<String, dynamic>),
      status: RequestStatus.fromMap(map['status'] as Map<String, dynamic>),
      deliveryDate: map['delivery_date'] as String,
      studentAttachments: map['student_attachments'] != null ? List.from(map['student_attachments'] as List) : [],
      studentNotes: map['student_notes'] != null ? map['student_notes'] as String : '',
      instructorAttachments: map['instructor_attachments'] != null ? List.from(map['instructor_attachments'] as List) : [],
      instructorNotes: map['instructor_notes'] != null ? map['instructor_notes'] as String : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) => RequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestModel(id: $id, title: $title, courseId: $courseId, type: $type, status: $status, deliveryDate: $deliveryDate, studentAttachments: $studentAttachments, studentNotes: $studentNotes, instructorAttachments: $instructorAttachments, instructorNotes: $instructorNotes)';
  }

  @override
  bool operator ==(covariant RequestModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.courseId == courseId &&
        other.type == type &&
        other.status == status &&
        other.deliveryDate == deliveryDate &&
        listEquals(other.studentAttachments, studentAttachments) &&
        other.studentNotes == studentNotes &&
        listEquals(other.instructorAttachments, instructorAttachments) &&
        other.instructorNotes == instructorNotes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        courseId.hashCode ^
        type.hashCode ^
        status.hashCode ^
        deliveryDate.hashCode ^
        studentAttachments.hashCode ^
        studentNotes.hashCode ^
        instructorAttachments.hashCode ^
        instructorNotes.hashCode;
  }
}

List<RequestModel> requestListFromMap(List source) {
  final List<RequestModel> requests = [];
  for (var element in source) {
    requests.add(RequestModel.fromMap(element));
  }
  return requests;
}
