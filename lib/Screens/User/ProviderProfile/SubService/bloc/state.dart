abstract class UserSubListState{}
class UserSubListInitState extends UserSubListState{}
class UserSubListLoadingState extends UserSubListState{}
class UserSubListSuccessState extends UserSubListState{}
class UserSubListErrorState extends UserSubListState{
  String error;
  UserSubListErrorState(this.error);
}