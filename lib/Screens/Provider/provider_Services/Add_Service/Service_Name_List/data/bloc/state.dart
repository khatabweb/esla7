import '../model/service_name_model.dart';

abstract class ServiceNameState{}
class ServiceNameInitState extends ServiceNameState{}
class ServiceNameLoadingState extends ServiceNameState{}
class ServiceNameSuccessState extends ServiceNameState{
  final ServiceNameModel serviceNameModel;
  ServiceNameSuccessState(this.serviceNameModel);
}
class ServiceNameErrorState extends ServiceNameState{
  String error;
  ServiceNameErrorState(this.error);
}