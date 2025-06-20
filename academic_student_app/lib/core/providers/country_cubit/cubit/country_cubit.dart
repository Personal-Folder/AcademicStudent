// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:academic_student/core/models/country.dart';
import 'package:academic_student/core/services/countries_service.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit() : super(CountryInitial());

  Future getCountries() async {
    emit(CountryLoading());

    await CountriesService().getCountries().then((result) {
      result.fold(
        (listResult) {
          emit(CountryLoaded(countries: countriesFromMapList(listResult[1])));
        },
        (stringResult) {
          log("get countries error");
          CustomDialogs().errorDialog(message: stringResult);
        },
      );
    });
  }
}
