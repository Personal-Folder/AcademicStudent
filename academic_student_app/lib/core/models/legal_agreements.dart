// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LegalAgreement {
  final String body;
  LegalAgreement({
    required this.body,
  });
  

  LegalAgreement copyWith({
    String? body,
  }) {
    return LegalAgreement(
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
    };
  }

  factory LegalAgreement.fromMap(Map<String, dynamic> map) {
    return LegalAgreement(
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LegalAgreement.fromJson(String source) => LegalAgreement.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LegalAgreement(body: $body)';

  @override
  bool operator ==(covariant LegalAgreement other) {
    if (identical(this, other)) return true;
  
    return 
      other.body == body;
  }

  @override
  int get hashCode => body.hashCode;
}
