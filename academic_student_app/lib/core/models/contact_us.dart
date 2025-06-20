// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContactUsInfo {
  final String type;
  final String value;
  ContactUsInfo({
    required this.type,
    required this.value,
  });

  ContactUsInfo copyWith({
    String? type,
    String? value,
  }) {
    return ContactUsInfo(
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

  factory ContactUsInfo.fromMap(Map<String, dynamic> map) {
    return ContactUsInfo(
      type: map['type'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactUsInfo.fromJson(String source) => ContactUsInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ContactUsInfo(type: $type, value: $value)';

  @override
  bool operator ==(covariant ContactUsInfo other) {
    if (identical(this, other)) return true;

    return other.type == type && other.value == value;
  }

  @override
  int get hashCode => type.hashCode ^ value.hashCode;
}

List<ContactUsInfo> contactUsInfoListFromMap(List source) {
  List<ContactUsInfo> contactUsInfo = [];
  for (var element in source) {
    contactUsInfo.add(ContactUsInfo.fromMap(element));
  }
  return contactUsInfo;
}
