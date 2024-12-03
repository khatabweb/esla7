abstract class OwnerUpdatePassState{}
class OwnerUpdatePassInitState extends OwnerUpdatePassState{}
class OwnerUpdatePassLoadingState extends OwnerUpdatePassState{}
class OwnerUpdatePassSuccessState extends OwnerUpdatePassState{}
class OwnerUpdatePassErrorState extends OwnerUpdatePassState{
  String error;
  OwnerUpdatePassErrorState(this.error);
}