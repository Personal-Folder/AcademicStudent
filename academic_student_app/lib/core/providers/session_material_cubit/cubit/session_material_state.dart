// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'session_material_cubit.dart';

@immutable
abstract class SessionMaterialState {}

class SessionMaterialInitial extends SessionMaterialState {}

class SessionMaterialLoading extends SessionMaterialState {}

class SessionMaterialLoaded extends SessionMaterialState {
  final List<SessionMaterial> sessionMaterials;
  SessionMaterialLoaded({
    required this.sessionMaterials,
  });
}
