// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserLogin extends UserEvent {
  final String countryCode;
  final String phoneNumber;
  final String password;

  UserLogin({
    required this.countryCode,
    required this.phoneNumber,
    required this.password,
  });
}

class UserAutoLogin extends UserEvent {}

class UserRegister extends UserEvent {
  final String firstName;
  final String lastName;
  final String countryCode;
  final String phoneNumber;
  final int countryId;
  final int universityId;
  final String email;
  final String password;
  final String confirmPassword;
  // final String verificationId;
  UserRegister({
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.phoneNumber,
    required this.countryId,
    required this.universityId,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class UserUpdate extends UserEvent {
  final List<dynamic> avatar;
  final String firstName;
  final String lastName;
  final String email;

  UserUpdate({
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}

class UserLogout extends UserEvent {}

class UserForgetPassword extends UserEvent {
  final String phoneNumber;

  UserForgetPassword({required this.phoneNumber});
}

class OTPVerification extends UserEvent {
  final String verificationId;
  final String countryCode;
  final String phoneNumber;
  final String email;
  final String otpType;
  final String otp;

  OTPVerification({required this.email, required this.otpType, required this.countryCode, required this.phoneNumber, required this.verificationId, required this.otp});
}

class ChangePassword extends UserEvent {
  final String newPassword;
  final String confirmNewPassword;

  ChangePassword({
    required this.newPassword,
    required this.confirmNewPassword,
  });
}

class DeleteUser extends UserEvent {}
