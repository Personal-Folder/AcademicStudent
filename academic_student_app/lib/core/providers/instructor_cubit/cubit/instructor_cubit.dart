// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/instructor.dart';
import 'package:academic_student/core/services/instructors_service.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'instructor_state.dart';

class InstructorCubit extends Cubit<InstructorState> {
  InstructorCubit() : super(InstructorInitial());

  Future getInstructors() async {
    emit(InstructorLoading());
    await InstructorService().getInstructors().then((result) {
      result.fold(
        (listResult) {
          emit(
            InstructorLoaded(
              instructors: instructorListFromMapList(
                listResult[1],
              ),
            ),
          );
        },
        (stringResult) {
          // CustomDialogs().errorDialog(message: stringResult);
        },
      );
    }).catchError((_) {
      Navigator.of(navigator!.context).pushReplacementNamed(loginScreenRoute);
    });
  }
}
