// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_us_cubit.dart';

@immutable
abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoading extends ContactUsState {}

class ContactUsLoaded extends ContactUsState {
  final List<ContactUsInfo> contactUsInfos;
  ContactUsLoaded({
    required this.contactUsInfos,
  });
}
