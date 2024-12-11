import '../model/model.dart';

abstract class SearchState{}
class SearchInitState extends SearchState{}
class SearchLoadingState extends SearchState{}
class SearchSuccessState extends SearchState{
  final SearchModel searchModel;
  SearchSuccessState(this.searchModel);
}
class SearchErrorState extends SearchState{
  String error;
  SearchErrorState(this.error);
}