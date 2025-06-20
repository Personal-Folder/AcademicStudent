import 'package:academic_student/core/models/instructor.dart';
import 'package:academic_student/core/services/staff_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  List<Instructor> _instructors = [];
  StaffBloc() : super(StaffInitial()) {
    on<InitializeStaff>((event, emit) async {
      emit(StaffInitial());
      final Either<List<Instructor>, String> result =
          await StaffService().getInstructors();
      result.fold((List<Instructor> l) {
        _instructors = List.from(l);
      }, (String message) {
      });
      emit(StaffLoaded(instructors: _instructors));
    });
  }
}
