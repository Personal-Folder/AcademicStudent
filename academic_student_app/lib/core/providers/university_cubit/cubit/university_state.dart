// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'university_cubit.dart';

@immutable
abstract class UniversityState {}

class UniversityInitial extends UniversityState {}

class UniversityLoading extends UniversityState {}

class UniversityLoaded extends UniversityState {
  final List<University> universities;
  UniversityLoaded({
    required this.universities,
  });
}

class UniversityError extends UniversityState {
  final String error;
  UniversityError({
    required this.error,
  });
}
