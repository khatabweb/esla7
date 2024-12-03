abstract class OwnerLoginState{}
class OwnerLoginInitState extends OwnerLoginState{}
class OwnerLoginLoadingState extends OwnerLoginState{}
class OwnerLoginSuccessState extends OwnerLoginState{}
class OwnerLoginErrorState extends OwnerLoginState{
  String error;
  OwnerLoginErrorState(this.error);
}