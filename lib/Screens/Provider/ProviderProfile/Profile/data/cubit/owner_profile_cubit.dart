import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/model.dart';
import '../repo/owner_profile_repo.dart';
part 'owner_profile_state.dart';

class OwnerProfileCubit extends Cubit<OwnerProfileState> {
  OwnerProfileCubit() : super(OwnerProfileInitial());

  late OwnerProfileModel profileModel;

  Future<void> getOwnerProfile() async {
    emit(OwnerProfileLoading());
    final response = await OwnerProfileRepo.getOwnerProfile();
    response.when(success: (success) {
      profileModel = success;
      emit(OwnerProfileSuccess(profileModel));
    }, failure: (failure) {
      emit(OwnerProfileError(failure.apiErrorModel.message!));
    });
  }
}
