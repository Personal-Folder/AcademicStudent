// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/footer.dart';
import 'package:academic_student/core/services/footer_data_service.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'footer_state.dart';

class FooterCubit extends Cubit<FooterState> {
  FooterCubit() : super(FooterInitial());

  Future getFooterData() async {
    emit(FooterLoading());

    await FooterDataService().getFooterData().then((result) {
      result.fold(
        (listResult) {
          emit(FooterLoaded(footerData: footerDataListFromMap(listResult[1])));
        },
        (stringResult) {
          CustomDialogs().errorDialog(message: stringResult);
        },
      );
    });
  }
}
