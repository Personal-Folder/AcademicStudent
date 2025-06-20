// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final int? id;
  final String? title;
  final bool? isFavorite;
  const Section({this.id, this.title, this.isFavorite});

  Section copyWith({int? id, String? title, bool? isFavorite}) {
    return Section(
        id: id ?? this.id,
        title: title ?? this.title,
        isFavorite: isFavorite ?? isFavorite);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
        id: map['id'] as int,
        title: map['title'] as String,
        isFavorite: map["is_favorite"]);
  }

  String toJson() => json.encode(toMap());

  factory Section.fromJson(Map<String, dynamic> json) => Section(
      id: json["id"] ?? -1,
      title: json["title"] ?? "",
      isFavorite: json["is_favorite"]);

  @override
  String toString() => 'Section(id: $id, title: $title)';

  @override
  bool operator ==(covariant Section other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

  @override
  List<int?> get props => [id];
}

List<Section> sectionFromMapList(List source) {
  List<Section> sections = [];

  for (var item in source) {
    sections.add(
      Section.fromMap(
        item,
      ),
    );
  }

  return sections;
}
