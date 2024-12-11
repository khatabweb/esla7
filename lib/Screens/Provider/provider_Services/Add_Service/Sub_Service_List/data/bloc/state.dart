import '../model/sub_service_model.dart';

abstract class SubServiceState {}

class SubServiceInitState extends SubServiceState {}

class SubServiceLoadingState extends SubServiceState {}

class SubServiceSuccessState extends SubServiceState {
  final SubServiceModel subServiceModel;
  SubServiceSuccessState(this.subServiceModel);
}

class SubServiceErrorState extends SubServiceState {
  String error;
  SubServiceErrorState(this.error);
}
