// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubscriptionType {
  final int id;
  final String key;
  final String name;
  SubscriptionType({
    required this.id,
    required this.key,
    required this.name,
  });

  SubscriptionType copyWith({
    int? id,
    String? key,
    String? name,
  }) {
    return SubscriptionType(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'key': key,
      'name': name,
    };
  }

  factory SubscriptionType.fromMap(Map<String, dynamic> map) {
    return SubscriptionType(
      id: map['id'] as int,
      key: map['key'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionType.fromJson(String source) => SubscriptionType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SubscriptionType(id: $id, key: $key, name: $name)';

  @override
  bool operator ==(covariant SubscriptionType other) {
    if (identical(this, other)) return true;

    return other.id == id && other.key == key && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode ^ name.hashCode;
}

List<SubscriptionType> subscriptionTypesFromMapList(List source) {
  final List<SubscriptionType> subscriptionTypes = [];
  for (var item in source) {
    subscriptionTypes.add(SubscriptionType.fromMap(item));
  }
  return subscriptionTypes;
}
