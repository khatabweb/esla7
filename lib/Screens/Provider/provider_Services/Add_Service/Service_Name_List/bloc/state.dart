abstract class ServiceNameState{}
class ServiceNameInitState extends ServiceNameState{}
class ServiceNameLoadingState extends ServiceNameState{}
class ServiceNameSuccessState extends ServiceNameState{}
class ServiceNameErrorState extends ServiceNameState{
  String error;
  ServiceNameErrorState(this.error);
}