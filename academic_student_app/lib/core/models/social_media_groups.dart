// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SocialMediaGroup {
  final int id;
  final String title;
  final String link;
  final String? image;
  SocialMediaGroup({
    required this.id,
    required this.title,
    required this.link,
    required this.image,
  });

  SocialMediaGroup copyWith({
    int? id,
    String? title,
    String? link,
    String? image,
  }) {
    return SocialMediaGroup(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'link': link,
      'image': image,
    };
  }

  factory SocialMediaGroup.fromMap(Map<String, dynamic> map) {
    return SocialMediaGroup(
      id: map['id'] as int,
      title: map['title'] as String,
      link: map['link'] as String,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialMediaGroup.fromJson(Map<String, dynamic> json) =>
      SocialMediaGroup(
          id: json["id"] ?? -1,
          title: json["title"] ?? "",
          link: json["link"] ?? "",
          image: json["image"] ?? "");

  @override
  String toString() {
    return 'SocialMediaGroup(id: $id, title: $title, link: $link, image: $image)';
  }

  @override
  bool operator ==(covariant SocialMediaGroup other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.link == link &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ link.hashCode ^ image.hashCode;
  }
}

List<SocialMediaGroup> socialMediaGroupsFromMapList(List source) {
  List<SocialMediaGroup> socialMediaGroups = [];
  for (var item in source) {
    socialMediaGroups.add(SocialMediaGroup.fromMap(item));
  }

  return socialMediaGroups;
}
