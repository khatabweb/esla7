abstract class AddServiceState{}
class AddServiceInitState extends AddServiceState{}
class AddServiceLoadingState extends AddServiceState{}
class AddServiceSuccessState extends AddServiceState{}
class AddServiceErrorState extends AddServiceState{
  String error;
  AddServiceErrorState(this.error);
}