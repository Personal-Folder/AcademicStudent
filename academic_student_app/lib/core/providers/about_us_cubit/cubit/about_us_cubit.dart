// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/about_us.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/helpers/dialogs.dart';
import '../../../services/settings_service.dart';

part 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(AboutUsInitial());

  Future getAboutUs() async {
    emit(AboutUsLoading());

    await SettingService().getAboutUs().then((result) {
      result.fold(
        (listResult) {
          emit(AboutUsLoaded(aboutUsList: aboutUsFromMapList(listResult[1])));
        },
        (stringResult) {
          CustomDialogs().errorDialog(message: stringResult);
        },
      );
    });
  }
}
