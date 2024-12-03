abstract class OwnersState{}
class OwnersInitState extends OwnersState{}
class OwnersLoadingState extends OwnersState{}
class OwnersSuccessState extends OwnersState{}
class OwnersErrorState extends OwnersState{
  String error;
  OwnersErrorState(this.error);
}