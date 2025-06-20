// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'country_cubit.dart';

@immutable
abstract class CountryState {}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState {
  final List<CountryModel> countries;
  CountryLoaded({
    required this.countries,
  });
}

class CountryError extends CountryState {
  final String error;
  CountryError({
    required this.error,
  });
}
