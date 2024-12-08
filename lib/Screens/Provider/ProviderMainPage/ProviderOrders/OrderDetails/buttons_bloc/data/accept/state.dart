abstract class AcceptState{}
class AcceptInitState extends AcceptState{}
class AcceptLoadingState extends AcceptState{}
class AcceptSuccessState extends AcceptState{}
class AcceptErrorState extends AcceptState{
  String error;
  AcceptErrorState(this.error);
}