// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:academic_student/core/models/contact_us.dart';
import 'package:academic_student/core/services/technical_support_service.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  Future getContactUsInfoData() async {
    emit(ContactUsLoading());

    await TechnicalSupportService().getTechnicalSupportDetails().then((result) {
      result.fold(
        (listResult) {
          emit(ContactUsLoaded(
              contactUsInfos: contactUsInfoListFromMap(listResult[1])));
        },
        (stringResult) {
          log('technical support error ');
          CustomDialogs().errorDialog(message: stringResult);
        },
      );
    });
  }
}
