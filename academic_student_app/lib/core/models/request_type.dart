// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestType {
  final int id;
  final String name;
  RequestType({
    required this.id,
    required this.name,
  });

  RequestType copyWith({
    int? id,
    String? name,
  }) {
    return RequestType(
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

  factory RequestType.fromMap(Map<String, dynamic> map) {
    return RequestType(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestType.fromJson(String source) => RequestType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RequestType(id: $id, name: $name)';

  @override
  bool operator ==(covariant RequestType other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

List<RequestType> requestTypesFromListMap(List source) {
  List<RequestType> requestTypes = [];
  for (var element in source) {
    requestTypes.add(RequestType.fromMap(element));
  }
  return requestTypes;
}
