import '../model/owner_details_model.dart';

abstract class OwnerDetailsState {}

class OwnerDetailsInitState extends OwnerDetailsState {}

class OwnerDetailsLoadingState extends OwnerDetailsState {}

class OwnerDetailsSuccessState extends OwnerDetailsState {
  final OwnerDetailsModel ownerDetailsModel;
  OwnerDetailsSuccessState({required this.ownerDetailsModel});
}

class OwnerDetailsErrorState extends OwnerDetailsState {
  String error;
  OwnerDetailsErrorState(this.error);
}
