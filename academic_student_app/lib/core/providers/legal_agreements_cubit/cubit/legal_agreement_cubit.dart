// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/models/legal_agreements.dart';
import 'package:academic_student/core/services/settings_service.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'legal_agreement_state.dart';

class LegalAgreementCubit extends Cubit<LegalAgreementState> {
  LegalAgreementCubit() : super(LegalAgreementInitial());
  Future getAllLegalAgreements(List<String> keys) async {
    emit(LegalAgreementLoading());
    final List<Map<String, LegalAgreement>> allLegalAgreements = [];
    bool success = false;
    for (var key in keys) {
      await SettingService().getLegalAgreements(key).then((result) {
        result.fold(
          (listResult) {
            allLegalAgreements.add(
              {key: LegalAgreement(body: listResult[1])},
            );
            success = true;
          },
          (stringResult) {
            CustomDialogs().errorDialog(message: stringResult);
          },
        );
      });
    }
    if (success) {
      emit(
        LegalAgreementLoaded(
          legalAgreements: allLegalAgreements,
        ),
      );
    } else {
      CustomDialogs().errorDialog(message: 'Error');
    }
  }
}
