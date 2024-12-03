abstract class EndServiceListState{}
class EndServiceListInitState extends EndServiceListState{}
class EndServiceListLoadingState extends EndServiceListState{}
class EndServiceListSuccessState extends EndServiceListState{}
class EndServiceListErrorState extends EndServiceListState{
  String error;
  EndServiceListErrorState(this.error);
}