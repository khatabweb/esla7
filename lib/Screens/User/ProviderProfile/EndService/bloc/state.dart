abstract class UserEndListState{}
class UserEndListInitState extends UserEndListState{}
class UserEndListLoadingState extends UserEndListState{}
class UserEndListSuccessState extends UserEndListState{}
class UserEndListErrorState extends UserEndListState{
  String error;
  UserEndListErrorState(this.error);
}