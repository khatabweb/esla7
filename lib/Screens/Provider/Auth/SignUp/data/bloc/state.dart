abstract class OwnerSignUpState{}
class OwnerSignUpInitState extends OwnerSignUpState{}
class OwnerSignUpLoadingState extends OwnerSignUpState{}
class OwnerSignUpSuccessState extends OwnerSignUpState{}
class OwnerSignUpErrorState extends OwnerSignUpState{
  String error;
  OwnerSignUpErrorState(this.error);
}