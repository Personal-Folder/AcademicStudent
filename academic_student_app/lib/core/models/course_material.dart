// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CourseMaterial {
  final int id;
  final String name;
  final String code;

  CourseMaterial({
    required this.id,
    required this.name,
    required this.code,
  });

  CourseMaterial copyWith({
    int? id,
    String? name,
    String? code,
  }) {
    return CourseMaterial(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
    };
  }

  factory CourseMaterial.fromMap(Map<String, dynamic> map) {
    return CourseMaterial(
      id: map['id'] as int,
      name: map['name'] as String,
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseMaterial.fromJson(String source) => CourseMaterial.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CourseMaterial(id: $id, name: $name, code: $code)';

  @override
  bool operator ==(covariant CourseMaterial other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.code == code;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ code.hashCode;
}

List<CourseMaterial> courseMaterialsFromListMap(List source) {
  List<CourseMaterial> materials = [];
  for (var element in source) {
    materials.add(CourseMaterial.fromMap(element));
  }
  return materials;
}
