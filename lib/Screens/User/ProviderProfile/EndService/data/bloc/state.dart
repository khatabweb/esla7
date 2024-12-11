import '../model/end_list_model.dart';

abstract class UserEndListState {}

class UserEndListInitState extends UserEndListState {}

class UserEndListLoadingState extends UserEndListState {}

class UserEndListSuccessState extends UserEndListState {
  final EndListModel endListModel;

  UserEndListSuccessState(this.endListModel);
}

class UserEndListErrorState extends UserEndListState {
  String error;
  UserEndListErrorState(this.error);
}
