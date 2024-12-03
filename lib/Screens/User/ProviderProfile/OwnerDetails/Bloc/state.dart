abstract class OwnerDetailsState{}
class OwnerDetailsInitState extends OwnerDetailsState{}
class OwnerDetailsLoadingState extends OwnerDetailsState{}
class OwnerDetailsSuccessState extends OwnerDetailsState{}
class OwnerDetailsErrorState extends OwnerDetailsState{
  String error;
  OwnerDetailsErrorState(this.error);
}