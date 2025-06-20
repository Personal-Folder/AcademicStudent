// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'course_material_cubit.dart';

@immutable
abstract class CourseMaterialState {}

class CourseMaterialInitial extends CourseMaterialState {}

class CourseMaterialLoading extends CourseMaterialState {}

class CourseMaterialLoaded extends CourseMaterialState {
  final List<CourseMaterial> courseMaterials;
  CourseMaterialLoaded({
    required this.courseMaterials,
  });
}
