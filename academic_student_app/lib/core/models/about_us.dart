// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AboutUsInfo {
  final String title;
  final String body;
  AboutUsInfo({
    required this.title,
    required this.body,
  });

  AboutUsInfo copyWith({
    String? title,
    String? body,
  }) {
    return AboutUsInfo(
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
    };
  }

  factory AboutUsInfo.fromMap(Map<String, dynamic> map) {
    return AboutUsInfo(
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutUsInfo.fromJson(String source) => AboutUsInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AboutUsInfo(title: $title, body: $body)';

  @override
  bool operator ==(covariant AboutUsInfo other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.body == body;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode;
}

List<AboutUsInfo> aboutUsFromMapList(List source) {
  final List<AboutUsInfo> aboutUs = [];

  for (var item in source) {
    aboutUs.add(
      AboutUsInfo.fromMap(item),
    );
  }

  return aboutUs;
}
