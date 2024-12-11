import '../../model/endlist_model.dart';

abstract class EndServiceListState {}

class EndServiceListInitState extends EndServiceListState {}

class EndServiceListLoadingState extends EndServiceListState {}

class EndServiceListSuccessState extends EndServiceListState {
  final EndServiceListModel endListModel;

  EndServiceListSuccessState({required this.endListModel});
}

class EndServiceListErrorState extends EndServiceListState {
  String error;
  EndServiceListErrorState(this.error);
}
