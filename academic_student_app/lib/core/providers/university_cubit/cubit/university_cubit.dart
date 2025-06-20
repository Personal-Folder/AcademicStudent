// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/university.dart';
import 'package:academic_student/core/services/universities_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/helpers/dialogs.dart';

part 'university_state.dart';

class UniversityCubit extends Cubit<UniversityState> {
  UniversityCubit() : super(UniversityInitial());
  Future getUniversities() async {
    emit(UniversityLoading());

    await UniversitiesService().getCountries().then((result) {
      result.fold(
        (listResult) {
          emit(UniversityLoaded(universities: universitiesFromMapList(listResult[1])));
        },
        (stringResult) {
          CustomDialogs().errorDialog(message: stringResult);
        },
      );
    });
  }
}
