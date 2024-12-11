import 'package:esla7/Screens/User/MainPage/UserOrders/OrderDetails/data/model/model.dart';

abstract class UserOrderDetailsState {}

class UserOrderDetailsInitState extends UserOrderDetailsState {}

class UserOrderDetailsLoadingState extends UserOrderDetailsState {}

class UserOrderDetailsSuccessState extends UserOrderDetailsState {
  UserOrderDetailsModel userOrderDetailsModel;
  UserOrderDetailsSuccessState(this.userOrderDetailsModel);
}

class UserOrderDetailsErrorState extends UserOrderDetailsState {
  String error;
  UserOrderDetailsErrorState(this.error);
}
