import '../../model/sublist_model.dart';

abstract class SubServiceListState{}
class SubServiceListInitState extends SubServiceListState{}
class SubServiceListLoadingState extends SubServiceListState{}
class SubServiceListSuccessState extends SubServiceListState{
  final SubServiceListModel subServiceListModel;
  SubServiceListSuccessState(this.subServiceListModel);
}
class SubServiceListErrorState extends SubServiceListState{
  String error;
  SubServiceListErrorState(this.error);
}