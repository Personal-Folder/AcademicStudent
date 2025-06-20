// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/request.dart';
import 'package:academic_student/core/services/request_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../utils/helpers/dialogs.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit() : super(RequestInitial());

  Future getUserRequests() async {
    emit(RequestLoading());
    await RequestService().getUserRequests().then((value) {
      value.fold(
        (listResult) {
          emit(
            RequestLoaded(
              requests: requestListFromMap(
                listResult[1],
              ),
            ),
          );
        },
        (stringResult) {
          CustomDialogs().errorDialog(message: stringResult);
        },
      );
    }).catchError((e) {
      CustomDialogs().errorDialog(message: e);
    });
  }
}
