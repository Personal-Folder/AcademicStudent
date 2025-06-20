// ignore_for_file: depend_on_referenced_packages

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarLoaded(indexSelected: 0));
  int indexSelected = 0;
  toggleTab(int tabSelected) {
    indexSelected = tabSelected;
    emit(BottomNavBarLoaded(indexSelected: tabSelected));
  }
}
