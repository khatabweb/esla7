abstract class RateState{}
class RateInitState extends RateState{}
class RateLoadingState extends RateState{}
class RateSuccessState extends RateState{}
class RateErrorState extends RateState{
  String error;
  RateErrorState(this.error);
}