// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Instructor {
  // final int id;
  final String? name;
  final String? avatar;
  Instructor({
    this.name,
    this.avatar,
  });

  Instructor copyWith({
    String? name,
    String? avatar,
  }) {
    return Instructor(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatar': avatar,
    };
  }

  factory Instructor.fromMap(Map<String, dynamic> map) {
    return Instructor(
      name: map['name'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Instructor.fromJson(Map<String, dynamic> json) =>
      Instructor(name: json["name"], avatar: json["avatar"]);

  @override
  String toString() => 'Instructor(name: $name, avatar: $avatar)';

  @override
  bool operator ==(covariant Instructor other) {
    if (identical(this, other)) return true;

    return other.name == name && other.avatar == avatar;
  }

  @override
  int get hashCode => name.hashCode ^ avatar.hashCode;
}

List<Instructor> instructorListFromMapList(List source) {
  final List<Instructor> instructors = [];
  for (var element in source) {
    instructors.add(Instructor.fromMap(element));
  }
  return instructors;
}
