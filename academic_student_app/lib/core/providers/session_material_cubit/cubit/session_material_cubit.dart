// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/session_material.dart';
import 'package:academic_student/core/services/session_material_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/helpers/dialogs.dart';

part 'session_material_state.dart';

class SessionMaterialCubit extends Cubit<SessionMaterialState> {
  SessionMaterialCubit() : super(SessionMaterialInitial());

  Future getSessionMaterials(String courseMaterialId) async {
    emit(SessionMaterialLoading());

    await SessionMaterialsService().getSessionMaterial(courseMaterialId).then((result) {
      result.fold(
        (listResult) {
          emit(
            SessionMaterialLoaded(
              sessionMaterials: sessionMaterialsFromListMap(
                listResult[1],
              ),
            ),
          );
        },
        (stringResult) {
          CustomDialogs().errorDialog(message: stringResult);
        },
      );
    }).catchError((e) {});
  }
}
