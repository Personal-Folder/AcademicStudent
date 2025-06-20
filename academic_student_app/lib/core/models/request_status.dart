// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestStatus {
  final int id;
  final String name;
  RequestStatus({
    required this.id,
    required this.name,
  });

  RequestStatus copyWith({
    int? id,
    String? name,
  }) {
    return RequestStatus(
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

  factory RequestStatus.fromMap(Map<String, dynamic> map) {
    return RequestStatus(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestStatus.fromJson(String source) => RequestStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RequestStatus(id: $id, name: $name)';

  @override
  bool operator ==(covariant RequestStatus other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
