abstract class CartState{}
class CartInitState extends CartState{}
class CartLoadingState extends CartState{}
class CartSuccessState extends CartState{}
class CartErrorState extends CartState{
  String error;
  CartErrorState(this.error);
}