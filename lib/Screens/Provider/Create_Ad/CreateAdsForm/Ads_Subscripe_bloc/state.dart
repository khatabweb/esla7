abstract class AdsSubscribeState{}
class AdsSubscribeInitState extends AdsSubscribeState{}
class AdsSubscribeLoadingState extends AdsSubscribeState{}
class AdsSubscribeSuccessState extends AdsSubscribeState{}
class AdsSubscribeErrorState extends AdsSubscribeState{
  String error;
  AdsSubscribeErrorState(this.error);
}