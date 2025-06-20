import 'dart:developer';

import 'package:academic_student/core/models/user.dart';
import 'package:academic_student/core/services/authentication_service.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(AuthenticationService authenticationService) : super(UserInitial()) {
    on<UserLogin>((event, emit) async {
      emit(UserLoading());
      await authenticationService
          .login(
        countryCode: event.countryCode,
        phoneNumber: event.phoneNumber,
        password: event.password,
      )
          .then((result) {
        result.fold(
          (listResult) async {
            if (listResult[0] == 'success') {
              emit(UserLoaded(
                user: listResult[1],
              ));
            } else if (listResult[0] == 'account_verification_failed') {
              emit(UnActiveUserLaoded(user: listResult[1]));
              CustomDialogs().showVerificationError(
                listResult[1].countryCode,
                listResult[1].phone,
                listResult[1].email,
              );
              // await verificationPhone(listResult[1]);
            } else {
              emit(UserValidationError(
                validationError: listResult[1],
              ));
            }
          },
          (stringResult) {
            emit(UserInitial());
            CustomDialogs().errorDialog(message: stringResult);
          },
        );
      }).catchError((error) {
        emit(UserInitial());
        CustomDialogs().errorDialog(message: error);
      });
    });

    on<UserRegister>(<bool>(UserRegister event, emit) async {
      emit(UserLoading());
      await authenticationService
          .register(
        firstName: event.firstName,
        lastName: event.lastName,
        countryCode: event.countryCode,
        phoneNumber: event.phoneNumber,
        universityId: event.universityId,
        countryId: event.countryId,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      )
          .then((result) {
        result.fold(
          (listResult) async {
            if (listResult[0] == 'success') {
              emit(UnActiveUserLaoded(
                user: listResult[1],
              ));
              // await verificationPhone(listResult[1]);
            } else {
              emit(UserValidationError(
                validationError: listResult[1],
              ));
              emit(UserInitial());
            }
          },
          (stringResult) {
            emit(UserInitial());
            CustomDialogs().errorDialog(message: stringResult);
          },
        );
      }).catchError((error) {
        emit(UserInitial());
        CustomDialogs().errorDialog(
            message: error is String
                ? error
                : 'Error Has Ocured. Please Contact Us, if that happend again!');
      });
    });

    on<UserLogout>((event, emit) async {
      final oldState = state as UserLoaded;
      emit(UserLoading());
      try {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        await authenticationService.logout().then((result) {
          result.fold(
            (listResult) async {
              if (listResult[0] == 'success') {
                emit(UserInitial());
                sharedPreferences.remove('cridentials');
                sharedPreferences.remove('user');
                sharedPreferences.remove('user_token');
              } else {
                emit(UserLoaded(user: oldState.user));
              }
            },
            (stringResult) {
              emit(UserLoaded(user: oldState.user));
              CustomDialogs().errorDialog(message: stringResult);
            },
          );
        });
      } catch (e) {
        emit(UserLoaded(user: oldState.user));
        CustomDialogs()
            .errorDialog(message: 'Couldn\'t Log you out! LOL, you are stuck!');
      }
    });

    on<OTPVerification>((OTPVerification event, emit) async {
      // final FirebaseAuth auth = FirebaseAuth.instance;
      final oldState = state as UnActiveUserLaoded;
      emit(UserLoading());

      // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: event.verificationId, smsCode: event.otp);
      try {
        // await auth.signInWithCredential(credential).then((value) async {
        //   if (await value.user?.getIdToken() != null) {
        await authenticationService
            .verifyAccount(
          countryCode: event.countryCode,
          phoneNumber: event.phoneNumber,
          email: event.email,
          otpType: event.otpType,
          otpToken: event.otp,
        )
            .then((result) {
          result.fold(
            (left) {
              if (left[0] == 'success') {
                emit(UserLoaded(user: left[1]));
                emit(UserInitial());
              }
            },
            (right) {
              emit(UnActiveUserLaoded(user: oldState.user));
              CustomDialogs().errorDialog(message: right);
            },
          );
          //   });
          // }
        }).catchError((error) {
          emit(UnActiveUserLaoded(user: oldState.user));
          CustomDialogs().errorDialog(
              message: error is String
                  ? error
                  : 'Error Has Ocured. Please Contact Us, if that happend again!');
        });
      } on FirebaseAuthException catch (_) {
        emit(UserValidationError(validationError: {'otp': 'not_valid'.tr}));
        emit(UnActiveUserLaoded(user: oldState.user));
      }
    });

    on<UserAutoLogin>((UserAutoLogin event, emit) async {
      emit(UserLoading());
      try {
        await AuthenticationService().validateToken().then((result) {
          result.fold(
            (listResult) {
              if (listResult[0] == 'success') {
                emit(UserLoaded(
                  user: listResult[1],
                ));
              } else {
                emit(UserInitial());
              }
            },
            (stringResult) {
              emit(UserInitial());
            },
          );
        });
      } catch (e) {
        emit(UserInitial());
      }
    });

    on<DeleteUser>((event, emit) async {
      final oldState = state as UserLoaded;
      emit(UserLoading());
      try {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        await authenticationService.selfDelete().then((result) {
          result.fold(
            (listResult) async {
              if (listResult[0] == 'success') {
                sharedPreferences.remove('cridentials');
                sharedPreferences.remove('user');
                sharedPreferences.remove('user_token');
                emit(UserInitial());
              } else {
                emit(UserLoaded(user: oldState.user));
              }
            },
            (stringResult) {
              emit(UserLoaded(user: oldState.user));
              CustomDialogs().errorDialog(message: stringResult);
            },
          );
        });
      } catch (e) {
        emit(UserLoaded(user: oldState.user));
        CustomDialogs()
            .errorDialog(message: 'Couldn\'t Log you out! LOL, you are stuck!');
      }
    });

    on<UserUpdate>((event, emit) async {
      final oldState = state as UserLoaded;
      emit(UserLoading());
      try {
        await authenticationService
            .updateUser(
          event.avatar,
          event.firstName,
          event.lastName,
          event.email,
        )
            .then((result) {
          result.fold(
            (listResult) async {
              if (listResult[0] == 'success') {
                emit(UserLoaded(user: listResult[1]));
              } else if (listResult[0] == 'error') {
                emit(UserValidationError(
                  validationError: listResult[1],
                ));
                emit(UserLoaded(user: oldState.user));
              } else {
                emit(UserLoaded(user: oldState.user));
              }
            },
            (stringResult) {
              emit(UserLoaded(user: oldState.user));
              CustomDialogs().errorDialog(message: stringResult);
            },
          );
        });
      } catch (e) {
        emit(UserLoaded(user: oldState.user));
        CustomDialogs()
            .errorDialog(message: 'Couldn\'t Edit Your User! We Are Sorry!');
      }
    });
  }
}
