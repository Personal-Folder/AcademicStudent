// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentMethod {
  int id;
  String name;
  String key;
  String image;
  PaymentMethod({
    required this.id,
    required this.name,
    required this.key,
    required this.image,
  });

  PaymentMethod copyWith({
    int? id,
    String? name,
    String? key,
    String? image,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      key: key ?? this.key,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'key': key,
      'image': image,
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'] as int,
      name: map['name'] as String,
      key: map['key'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromJson(String source) => PaymentMethod.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentMethod(id: $id, name: $name, key: $key, image: $image)';
  }

  @override
  bool operator ==(covariant PaymentMethod other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.key == key && other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ key.hashCode ^ image.hashCode;
  }
}

List<PaymentMethod> paymentMethodsFromListMap(List source) {
  List<PaymentMethod> paymentMethods = [];
  for (var element in source) {
    paymentMethods.add(PaymentMethod.fromMap(element));
  }
  return paymentMethods;
}
