// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class University {
  final int id;
  final String name;
  University({
    required this.id,
    required this.name,
  });

  University copyWith({
    int? id,
    String? name,
  }) {
    return University(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory University.fromMap(Map<String, dynamic> map) {
    return University(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory University.fromJson(String source) => University.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'University(id: $id, name: $name)';

  @override
  bool operator ==(covariant University other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

List<University> universitiesFromMapList(List source) {
  List<University> countries = [];
  for (var element in source) {
    countries.add(University.fromMap(element));
  }

  return countries;
}
