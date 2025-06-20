// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OnlineService {
  final int id;
  final String title;
  OnlineService({
    required this.id,
    required this.title,
  });

  OnlineService copyWith({
    int? id,
    String? title,
  }) {
    return OnlineService(
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

  factory OnlineService.fromMap(Map<String, dynamic> map) {
    return OnlineService(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnlineService.fromJson(String source) => OnlineService.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OnlineService(id: $id, title: $title)';

  @override
  bool operator ==(covariant OnlineService other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
