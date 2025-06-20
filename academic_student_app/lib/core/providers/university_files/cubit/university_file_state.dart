part of 'university_file_cubit.dart';

@immutable
abstract class UniversityFileState {}

class UniversityFileInitial extends UniversityFileState {}

class UniversityFileLoading extends UniversityFileState {}

class UniversityFileLoaded extends UniversityFileState {
  final List<UniversityFile> universityFiles;
  UniversityFileLoaded({
    required this.universityFiles,
  });
}
