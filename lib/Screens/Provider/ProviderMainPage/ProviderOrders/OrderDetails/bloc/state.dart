abstract class OwnerOrderDetailsState{}
class OwnerOrderDetailsInitState extends OwnerOrderDetailsState{}
class OwnerOrderDetailsLoadingState extends OwnerOrderDetailsState{}
class OwnerOrderDetailsSuccessState extends OwnerOrderDetailsState{}
class OwnerOrderDetailsErrorState extends OwnerOrderDetailsState{
  String error;
  OwnerOrderDetailsErrorState(this.error);
}