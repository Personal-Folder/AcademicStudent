// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UniversityFile {
  final int id;
  final String title;
  final String link;
  UniversityFile({
    required this.id,
    required this.title,
    required this.link,
  });

  UniversityFile copyWith({
    int? id,
    String? title,
    String? link,
  }) {
    return UniversityFile(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'link': link,
    };
  }

  factory UniversityFile.fromMap(Map<String, dynamic> map) {
    return UniversityFile(
      id: map['id'] as int,
      title: map['title'] as String,
      link: map['link'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UniversityFile.fromJson(Map<String, dynamic> json) => UniversityFile(
      id: json["id"] ?? -1,
      title: json["title"] ?? "",
      link: json["link"] ?? "");

  @override
  String toString() => 'UniversityFile(id: $id, title: $title, link: $link)';

  @override
  bool operator ==(covariant UniversityFile other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.link == link;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ link.hashCode;
}

List<UniversityFile> universityFileFromMapList(List source) {
  List<UniversityFile> universityFiles = [];
  for (var item in source) {
    universityFiles.add(UniversityFile.fromMap(item));
  }
  return universityFiles;
}
