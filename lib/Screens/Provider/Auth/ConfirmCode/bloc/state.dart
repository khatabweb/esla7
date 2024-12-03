abstract class OwnerVerifyState{}
class OwnerVerifyInitState extends OwnerVerifyState{}
class OwnerVerifyLoadingState extends OwnerVerifyState{}
class OwnerVerifySuccessState extends OwnerVerifyState{}
class OwnerVerifyErrorState extends OwnerVerifyState{
  String error;
  OwnerVerifyErrorState(this.error);
}