// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'major_cubit.dart';

@immutable
abstract class MajorState {}

class MajorInitial extends MajorState {}

class MajorLoading extends MajorState {}

class MajorLoaded extends MajorState {
  final List<Major> majors;
  MajorLoaded({
    required this.majors,
  });
}
