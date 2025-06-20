// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sections_cubit.dart';

@immutable
abstract class SectionsState {
  const SectionsState();
}

class SectionsInitial extends SectionsState {}

class SectionsLoading extends SectionsState {}

class SectionLoading extends SectionsState {
  final Section section;
  final List<Section> sections;
  const SectionLoading({
    required this.section,
    required this.sections,
  });
}

class SectionsLoaded extends SectionsState {
  final List<Section> sections;
  const SectionsLoaded({
    required this.sections,
  });
}
