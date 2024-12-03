abstract class CheckoutState{}
class CheckoutInitState extends CheckoutState{}
class CheckoutLoadingState extends CheckoutState{}
class CheckoutSuccessState extends CheckoutState{}
class CheckoutErrorState extends CheckoutState{
  String error;
  CheckoutErrorState(this.error);
}