// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookHelpButton {
  final String title;
  final String? link;
  BookHelpButton({
    required this.title,
    required this.link,
  });

  BookHelpButton copyWith({
    String? title,
    String? link,
  }) {
    return BookHelpButton(
      title: title ?? this.title,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'link': link,
    };
  }

  factory BookHelpButton.fromMap(Map<String, dynamic> map) {
    return BookHelpButton(
      title: map['title'] as String,
      link: map['link'] != null ? map['link'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookHelpButton.fromJson(String source) => BookHelpButton.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BookHelpButton(title: $title, link: $link)';

  @override
  bool operator ==(covariant BookHelpButton other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.link == link;
  }

  @override
  int get hashCode => title.hashCode ^ link.hashCode;
}
