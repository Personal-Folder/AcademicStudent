part of 'payment_method_cubit.dart';

@immutable
abstract class PaymentMethodState {}

class PaymentMethodInitial extends PaymentMethodState {}

class PaymentMethodLoaded extends PaymentMethodState {
  final List<PaymentMethod> paymentMethods;
  PaymentMethodLoaded({
    required this.paymentMethods,
  });
}

class PaymentMethodLoading extends PaymentMethodState {}
