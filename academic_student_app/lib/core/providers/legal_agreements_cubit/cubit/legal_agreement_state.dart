// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'legal_agreement_cubit.dart';

@immutable
abstract class LegalAgreementState {}

class LegalAgreementInitial extends LegalAgreementState {}

class LegalAgreementLoading extends LegalAgreementState {}

class LegalAgreementLoaded extends LegalAgreementState {
  final List<Map<String, LegalAgreement>> legalAgreements;
  LegalAgreementLoaded({
    required this.legalAgreements,
  });
}
