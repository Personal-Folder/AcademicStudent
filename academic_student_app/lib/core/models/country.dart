// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CountryModel {
  final int id;
  final String name;
  CountryModel({
    required this.id,
    required this.name,
  });

  CountryModel copyWith({
    int? id,
    String? name,
  }) {
    return CountryModel(
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

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryModel.fromJson(String source) => CountryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Country(id: $id, name: $name)';

  @override
  bool operator ==(covariant CountryModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

List<CountryModel> countriesFromMapList(List source) {
  List<CountryModel> countries = [];
  for (var element in source) {
    countries.add(CountryModel.fromMap(element));
  }

  return countries;
}
