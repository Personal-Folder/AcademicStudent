// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:academic_student/core/models/country.dart';
import 'package:academic_student/core/models/university.dart';

class User {
  static String token = '';

  final int id;
  final String? avatar;
  final String firstName;
  final String lastName;
  final String countryCode;
  final String phone;
  final String email;
  final CountryModel country;
  final University university;
  final bool accountVerified;
  User({
    required this.id,
    this.avatar,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.phone,
    required this.email,
    required this.country,
    required this.university,
    required this.accountVerified,
  });

  User copyWith({
    int? id,
    String? avatar,
    String? firstName,
    String? lastName,
    String? countryCode,
    String? phone,
    String? email,
    CountryModel? country,
    University? university,
    bool? accountVerified,
  }) {
    return User(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      countryCode: countryCode ?? this.countryCode,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      country: country ?? this.country,
      university: university ?? this.university,
      accountVerified: accountVerified ?? this.accountVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'avatar': avatar,
      'first_name': firstName,
      'last_name': lastName,
      'country_code': countryCode,
      'phone': phone,
      'email': email,
      'country': country.toMap(),
      'university': university.toMap(),
      'account_verified': accountVerified,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      countryCode: map['country_code'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      country: CountryModel.fromMap(map['country'] as Map<String, dynamic>),
      university: University.fromMap(map['university'] as Map<String, dynamic>),
      accountVerified: map['account_verified'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, avatar: $avatar, firstName: $firstName, lastName: $lastName, countryCode: $countryCode, phone: $phone, email: $email, country: $country, university: $university, accountVerified: $accountVerified)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.avatar == avatar &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.countryCode == countryCode &&
        other.phone == phone &&
        other.email == email &&
        other.country == country &&
        other.university == university &&
        other.accountVerified == accountVerified;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        avatar.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        countryCode.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        country.hashCode ^
        university.hashCode ^
        accountVerified.hashCode;
  }
}
