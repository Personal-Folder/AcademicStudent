// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Major {
  final int id;
  final String title;
  Major({
    required this.id,
    required this.title,
  });

  Major copyWith({
    int? id,
    String? title,
  }) {
    return Major(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory Major.fromMap(Map<String, dynamic> map) {
    return Major(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Major.fromJson(String source) => Major.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Major(id: $id, title: $title)';

  @override
  bool operator ==(covariant Major other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}

List<Major> majorsFromMapList(List source) {
  final List<Major> majors = [];
  for (var item in source) {
    majors.add(Major.fromMap(item));
  }
  return majors;
}
