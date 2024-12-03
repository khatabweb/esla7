abstract class SearchState{}
class SearchInitState extends SearchState{}
class SearchLoadingState extends SearchState{}
class SearchSuccessState extends SearchState{}
class SearchErrorState extends SearchState{
  String error;
  SearchErrorState(this.error);
}