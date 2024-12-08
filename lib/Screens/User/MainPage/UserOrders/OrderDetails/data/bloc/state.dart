abstract class UserOrderDetailsState{}
class UserOrderDetailsInitState extends UserOrderDetailsState{}
class UserOrderDetailsLoadingState extends UserOrderDetailsState{}
class UserOrderDetailsSuccessState extends UserOrderDetailsState{}
class UserOrderDetailsErrorState extends UserOrderDetailsState{
  String error;
  UserOrderDetailsErrorState(this.error);
}