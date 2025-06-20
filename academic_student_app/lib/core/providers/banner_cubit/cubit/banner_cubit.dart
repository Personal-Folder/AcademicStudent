// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/banner.dart' as banner_prefix;
import 'package:academic_student/core/services/banners_service.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerInitial());

  Future getBanners() async {
    emit(BannerLoading());

    await BannersService().getBanners().then((result) {
      result.fold(
        (listResult) {
          emit(
            BannerLoaded(
              banners: banner_prefix.bannersFromListMap(
                listResult[1],
              ),
            ),
          );
        },
        (stringResult) {
          // CustomDialogs().errorDialog(message: stringResult);
        },
      );
    }).catchError((e) {
      Navigator.of(navigator!.context).pushReplacementNamed(loginScreenRoute);
    });
  }
}
