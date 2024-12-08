abstract class OwnerUpdateState{}
class OwnerUpdateInitState extends OwnerUpdateState{}
class OwnerUpdateLoadingState extends OwnerUpdateState{}
class OwnerUpdateSuccessState extends OwnerUpdateState{}
class OwnerUpdateErrorState extends OwnerUpdateState{
  String error;
  OwnerUpdateErrorState(this.error);
}