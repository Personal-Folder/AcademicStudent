// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Banner {
  final int id;
  final String? urlLg;
  final String? urlSm;
  Banner({
    required this.id,
    this.urlLg,
    this.urlSm,
  });

  Banner copyWith({
    int? id,
    String? urlLg,
    String? urlSm,
  }) {
    return Banner(
      id: id ?? this.id,
      urlLg: urlLg ?? this.urlLg,
      urlSm: urlSm ?? this.urlSm,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url_lg': urlLg,
      'url_sm': urlSm,
    };
  }

  factory Banner.fromMap(Map<String, dynamic> map) {
    return Banner(
      id: map['id'] as int,
      urlLg: map['url_lg'] != null ? map['url_lg'] as String : null,
      urlSm: map['url_sm'] != null ? map['url_sm'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Banner.fromJson(String source) => Banner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Banner(id: $id, urlLg: $urlLg, urlSm: $urlSm)';

  @override
  bool operator ==(covariant Banner other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.urlLg == urlLg &&
      other.urlSm == urlSm;
  }

  @override
  int get hashCode => id.hashCode ^ urlLg.hashCode ^ urlSm.hashCode;
}

List<Banner> bannersFromListMap(List source) {
  List<Banner> banners = [];
  for (var element in source) {
    banners.add(Banner.fromMap(element));
  }
  return banners;
}
