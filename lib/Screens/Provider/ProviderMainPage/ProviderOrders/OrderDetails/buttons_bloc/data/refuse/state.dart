abstract class RefuseState{}
class RefuseInitState extends RefuseState{}
class RefuseLoadingState extends RefuseState{}
class RefuseSuccessState extends RefuseState{}
class RefuseErrorState extends RefuseState{
  String error;
  RefuseErrorState(this.error);
}