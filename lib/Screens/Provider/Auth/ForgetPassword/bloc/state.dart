abstract class OwnerResetState{}
class OwnerResetInitState extends OwnerResetState{}
class OwnerResetLoadingState extends OwnerResetState{}
class OwnerResetSuccessState extends OwnerResetState{}
class OwnerResetErrorState extends OwnerResetState{
  String error;
  OwnerResetErrorState(this.error);
}