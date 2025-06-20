import 'package:academic_student/core/models/social_media_groups.dart';
import 'package:academic_student/core/services/social_media_groups_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'social_media_groups_state.dart';

class SocialMediaGroupsCubit extends Cubit<SocialMediaGroupsState> {
  SocialMediaGroupsCubit() : super(SocialMediaGroupsInitial());
  List<SocialMediaGroup> _whatsappGroups = [];
  Future getSocialMediaGroups() async {
    emit(SocialMediaGroupsLoading());
    await SocialMediaGroupsService().getSocialGroups().then((result) {
      result.fold(
        (listResult) {
          _whatsappGroups = listResult;
          emit(
            SocialMediaGroupsLoaded(socialMediaGroups: _whatsappGroups),
          );
        },
        (stringResult) {
          // CustomDialogs().errorDialog(message: stringResult);
        },
      );
    }).catchError((e) {
      // Navigator.of(navigator!.context).pushReplacementNamed(loginScreenRoute);
    });
  }
}
