import 'package:academic_student/core/models/section.dart';
import 'package:academic_student/core/services/sections_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

part 'sections_state.dart';

class SectionsCubit extends Cubit<SectionsState> {
  SectionsCubit() : super(SectionsInitial());
  List<Section> _sections = [];
  Future getSections() async {
    emit(SectionsLoading());

    await SectionService().getSections().then((result) {
      result.fold(
        (listResult) {
          _sections = listResult;
          emit(
            SectionsLoaded(sections: _sections),
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

  Future toggleFavoriteSection(Section section) async {
    emit(SectionLoading(section: section, sections: _sections));
    final Either<void, String> result =
        await SectionService().toggleSectionFavorite(section.id ?? -1);
    result.fold((v) {
      int index = _sections.indexOf(section);
      _sections[index] = _sections[index]
          .copyWith(isFavorite: !(_sections[index].isFavorite ?? false));
      emit(SectionsLoaded(sections: _sections));
    }, (String m) {
      emit(SectionsLoaded(sections: _sections));
    });
  }
}
