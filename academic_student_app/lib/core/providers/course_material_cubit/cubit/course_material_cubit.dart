// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/course_material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/helpers/dialogs.dart';
import '../../../services/course_materials_service.dart';

part 'course_material_state.dart';

class CourseMaterialCubit extends Cubit<CourseMaterialState> {
  CourseMaterialCubit() : super(CourseMaterialInitial());

  Future getCourseMaterials(String majorId) async {
    emit(CourseMaterialLoading());

    await CourseMaterialService().getCourseMaterial(majorId).then((result) {
      result.fold(
        (listResult) {
          emit(
            CourseMaterialLoaded(
              courseMaterials: courseMaterialsFromListMap(
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
