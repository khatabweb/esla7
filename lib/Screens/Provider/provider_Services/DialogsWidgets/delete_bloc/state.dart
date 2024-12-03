abstract class DeleteServiceState{}
class DeleteServiceInitState extends DeleteServiceState{}
class DeleteServiceLoadingState extends DeleteServiceState{}
class DeleteServiceSuccessState extends DeleteServiceState{}
class DeleteServiceErrorState extends DeleteServiceState{
  String error;
  DeleteServiceErrorState(this.error);
}