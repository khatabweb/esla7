abstract class SubServiceState{}
class SubServiceInitState extends SubServiceState{}
class SubServiceLoadingState extends SubServiceState{}
class SubServiceSuccessState extends SubServiceState{}
class SubServiceErrorState extends SubServiceState{
  String error;
  SubServiceErrorState(this.error);
}