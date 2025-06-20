part of 'footer_cubit.dart';

@immutable
abstract class FooterState {}

class FooterInitial extends FooterState {}

class FooterLoading extends FooterState {}

class FooterLoaded extends FooterState {
  final List<FooterData> footerData;
  FooterLoaded({
    required this.footerData,
  });
}
