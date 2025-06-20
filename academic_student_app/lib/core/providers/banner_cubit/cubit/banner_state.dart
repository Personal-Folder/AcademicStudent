// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'banner_cubit.dart';

@immutable
abstract class BannerState {}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  final List<banner_prefix.Banner> banners;
  BannerLoaded({
    required this.banners,
  });
}
