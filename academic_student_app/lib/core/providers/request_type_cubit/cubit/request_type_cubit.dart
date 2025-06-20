// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/request_type.dart';
import 'package:academic_student/core/services/request_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/helpers/dialogs.dart';

part 'request_type_state.dart';

class RequestTypeCubit extends Cubit<RequestTypeState> {
  RequestTypeCubit() : super(RequestTypeInitial());

  Future getRequestTypes() async {
    emit(RequestTypeLoading());

    await RequestService().getRequestTypes().then((result) {
      result.fold(
        (listResult) {
          emit(
            RequestTypeLoaded(
              requestTypes: requestTypesFromListMap(
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
