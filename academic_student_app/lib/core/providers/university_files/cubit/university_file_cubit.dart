// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:academic_student/core/models/university_file.dart';
import 'package:academic_student/core/services/university_file_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

part 'university_file_state.dart';

class UniversityFileCubit extends Cubit<UniversityFileState> {
  UniversityFileCubit() : super(UniversityFileInitial());
  List<UniversityFile> _universityFiles = [];
  Future getUniversityFiles() async {
    emit(UniversityFileLoading());
    await UniversityFileService().getUniversityFiles().then((result) {
      result.fold(
        (listResult) {
          _universityFiles = listResult;
          emit(
            UniversityFileLoaded(
              universityFiles: _universityFiles,
            ),
          );
        },
        (stringResult) {},
      );
    }).catchError((_) {
      // Navigator.of(navigator!.context).pushReplacementNamed(loginScreenRoute);
    });
  }
}
