// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded({required this.user});
}

class UserTokenValidated extends UserState {
  final bool validated;
  final List data;
  UserTokenValidated({
    required this.validated,
    required this.data,
  });
}

class UnActiveUserLaoded extends UserState {
  final User user;

  UnActiveUserLaoded({
    required this.user,
  });
}

class UserValidationError extends UserState {
  final Map validationError;

  UserValidationError({required this.validationError});
}
