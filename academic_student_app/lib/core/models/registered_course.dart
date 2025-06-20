import 'package:equatable/equatable.dart';

class RegisteredCourse extends Equatable {
  const RegisteredCourse(
      {this.code,
      this.courseId,
      this.id,
      this.name,
      this.type,
      this.isFavorite = false});
  final int? id;
  final String? name;
  final String? code;
  final String? type;
  final bool? isFavorite;
  final int? courseId;
  RegisteredCourse.fromJson(Map<String, dynamic> json)
      : code = json["code"],
        courseId = json["course_id"],
        id = json["id"],
        name = json["name"],
        isFavorite = json["is_favorite"],
        type = json["type"];
  RegisteredCourse copyWith({bool? isFavorite}) => RegisteredCourse(
      code: code,
      id: id,
      courseId: courseId,
      name: name,
      type: type,
      isFavorite: isFavorite ?? this.isFavorite);
  @override
  List<int?> get props => [id];
}
