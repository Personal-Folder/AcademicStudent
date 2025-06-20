// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'request_cubit.dart';

@immutable
abstract class RequestState {}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestLoaded extends RequestState {
  final List<RequestModel> requests;
  RequestLoaded({
    required this.requests,
  });
}
