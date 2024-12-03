abstract class ComplaintsState{}
class ComplaintsInitState extends ComplaintsState{}
class ComplaintsLoadingState extends ComplaintsState{}
class ComplaintsSuccessState extends ComplaintsState{}
class ComplaintsErrorState extends ComplaintsState{
  String error;
  ComplaintsErrorState(this.error);
}