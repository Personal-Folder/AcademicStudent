part of 'bottom_nav_bar_cubit.dart';

@immutable
abstract class BottomNavBarState {}

class BottomNavBarLoaded extends BottomNavBarState {
  final int indexSelected;
  BottomNavBarLoaded({required this.indexSelected});
}
