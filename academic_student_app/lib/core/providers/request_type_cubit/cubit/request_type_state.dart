// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'request_type_cubit.dart';

@immutable
abstract class RequestTypeState {}

class RequestTypeInitial extends RequestTypeState {}

class RequestTypeLoading extends RequestTypeState {}

class RequestTypeLoaded extends RequestTypeState {
  final List<RequestType> requestTypes;
  RequestTypeLoaded({
    required this.requestTypes,
  });
}
