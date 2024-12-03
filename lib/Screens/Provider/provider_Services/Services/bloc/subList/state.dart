abstract class SubServiceListState{}
class SubServiceListInitState extends SubServiceListState{}
class SubServiceListLoadingState extends SubServiceListState{}
class SubServiceListSuccessState extends SubServiceListState{}
class SubServiceListErrorState extends SubServiceListState{
  String error;
  SubServiceListErrorState(this.error);
}