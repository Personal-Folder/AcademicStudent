import 'package:rive/rive.dart';

class RiveModel {
  final String src;
  final String artboard;
  final String stateMachineName;
  late SMIBool? status;
  RiveModel({
    required this.artboard,
    required this.src,
    required this.stateMachineName,
    this.status,
  });
  set setStatus(SMIBool state) {
    status = state;
  }
}
