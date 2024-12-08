abstract class UserUpdateState{}
class UserUpdateInitState extends UserUpdateState{}
class UserUpdateLoadingState extends UserUpdateState{}
class UserUpdateSuccessState extends UserUpdateState{}
class UserUpdateErrorState extends UserUpdateState{
  String error;
  UserUpdateErrorState(this.error);
}