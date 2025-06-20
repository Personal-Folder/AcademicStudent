part of 'book_help_button_cubit.dart';

@immutable
abstract class BookHelpButtonState {}

class BookHelpButtonInitial extends BookHelpButtonState {}

class BookHelpButtonLoading extends BookHelpButtonState {}

class BookHelpButtonLoaded extends BookHelpButtonState {
  final BookHelpButton bookHelpButton;
  BookHelpButtonLoaded({
    required this.bookHelpButton,
  });
}
