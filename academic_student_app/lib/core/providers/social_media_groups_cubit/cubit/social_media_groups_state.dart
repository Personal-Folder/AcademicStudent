// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'social_media_groups_cubit.dart';

@immutable
abstract class SocialMediaGroupsState {}

class SocialMediaGroupsInitial extends SocialMediaGroupsState {}

class SocialMediaGroupsLoading extends SocialMediaGroupsState {}

class SocialMediaGroupsLoaded extends SocialMediaGroupsState {
  final List<SocialMediaGroup> socialMediaGroups;
  SocialMediaGroupsLoaded({
    required this.socialMediaGroups,
  });
}
