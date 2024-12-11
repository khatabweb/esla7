import '../model/model.dart';

abstract class UserSubListState {}

class UserSubListInitState extends UserSubListState {}

class UserSubListLoadingState extends UserSubListState {}

class UserSubListSuccessState extends UserSubListState {
  SubListModel subListModel;
  UserSubListSuccessState(this.subListModel);
}

class UserSubListErrorState extends UserSubListState {
  String error;
  UserSubListErrorState(this.error);
}
