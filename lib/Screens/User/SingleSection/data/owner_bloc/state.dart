import 'model.dart';



abstract class OwnersState{}
class OwnersInitState extends OwnersState{}
class OwnersLoadingState extends OwnersState{}
class OwnersSuccessState extends OwnersState{
  final OwnerModel ownersModel;
  OwnersSuccessState({required this.ownersModel});
}
class OwnersErrorState extends OwnersState{
  String error;
  OwnersErrorState(this.error);
}