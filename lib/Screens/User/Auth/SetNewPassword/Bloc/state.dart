abstract class UpdatePasswordState{}
class UpdatePasswordInitState extends UpdatePasswordState{}
class UpdatePasswordLoadingState extends UpdatePasswordState{}
class UpdatePasswordSuccessState extends UpdatePasswordState{}
class UpdatePasswordErrorState extends UpdatePasswordState{
  String error;
  UpdatePasswordErrorState(this.error);
}