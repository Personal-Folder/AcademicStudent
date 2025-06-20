// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/book_help_button.dart';
import 'package:academic_student/core/services/book_help_button_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'book_help_button_state.dart';

class BookHelpButtonCubit extends Cubit<BookHelpButtonState> {
  BookHelpButtonCubit() : super(BookHelpButtonInitial());

  Future getBookHelpButtonData() async {
    emit(BookHelpButtonLoading());

    await BookHelpButtonService().getBookHelpButtonData().then((result) {
      result.fold(
        (listResult) {
          emit(
            BookHelpButtonLoaded(
              bookHelpButton: BookHelpButton(
                title: listResult[1]['title'],
                link: listResult[1]['link'],
              ),
            ),
          );
        },
        (stringResult) {},
      );
    }).catchError((e) {});
  }
}
