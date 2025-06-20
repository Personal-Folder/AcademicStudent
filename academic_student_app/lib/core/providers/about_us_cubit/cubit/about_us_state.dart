part of 'about_us_cubit.dart';

@immutable
abstract class AboutUsState {}

class AboutUsInitial extends AboutUsState {}

class AboutUsLoading extends AboutUsState {}

class AboutUsLoaded extends AboutUsState {
  final List<AboutUsInfo> aboutUsList;
  AboutUsLoaded({
    required this.aboutUsList,
  });
}
