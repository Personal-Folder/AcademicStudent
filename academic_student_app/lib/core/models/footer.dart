// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FooterData {
  final String type;
  final String? value;
  FooterData({
    required this.type,
    required this.value,
  });

  FooterData copyWith({
    String? type,
    String? value,
  }) {
    return FooterData(
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'value': value,
    };
  }

  factory FooterData.fromMap(Map<String, dynamic> map) {
    return FooterData(
      type: map['type'] as String,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FooterData.fromJson(String source) => FooterData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FooterData(type: $type, value: $value)';

  @override
  bool operator ==(covariant FooterData other) {
    if (identical(this, other)) return true;

    return other.type == type && other.value == value;
  }

  @override
  int get hashCode => type.hashCode ^ value.hashCode;
}

List<FooterData> footerDataListFromMap(List source) {
  List<FooterData> contactUsInfo = [];
  for (var element in source) {
    contactUsInfo.add(FooterData.fromMap(element));
  }
  return contactUsInfo;
}
