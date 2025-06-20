// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/major.dart';
import 'package:academic_student/core/services/majors_service.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'major_state.dart';

class MajorCubit extends Cubit<MajorState> {
  MajorCubit() : super(MajorInitial());

  Future getMajors(String sectionId) async {
    emit(MajorLoading());

    await MajorService().getMajors(sectionId).then((result) {
      result.fold(
        (listResult) {
          emit(
            MajorLoaded(
              majors: majorsFromMapList(
                listResult[1],
              ),
            ),
          );
        },
        (stringResult) {
          CustomDialogs().errorDialog(message: stringResult);
        },
      );
    });
  }
}
