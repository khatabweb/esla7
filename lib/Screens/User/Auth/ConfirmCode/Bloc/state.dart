abstract class ConfirmCodeState{}

class ConfirmCodeInitState extends ConfirmCodeState{}
class ConfirmCodeLoadingState extends ConfirmCodeState{}
class ConfirmCodeSuccessState extends ConfirmCodeState{}
class ConfirmCodeErrorState extends ConfirmCodeState{
  String error;
  ConfirmCodeErrorState(this.error);
}