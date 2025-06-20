// ignore_for_file: depend_on_referenced_packages

import 'package:academic_student/core/services/payment_method_service.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:academic_student/core/models/payment_method.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodInitial());

  Future getPaymentMethods() async {
    emit(PaymentMethodLoading());

      await PaymentService().getPaymentMethods().then((result) {
        result.fold(
          (listResult) {
            emit(
              PaymentMethodLoaded(
                paymentMethods: paymentMethodsFromListMap(
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
