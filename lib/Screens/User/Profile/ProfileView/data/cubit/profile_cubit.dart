import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../API/profile_controller.dart';
import '../model/profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  late ProfileModel profileModel;
  Future<void> getUserProfile() async {
    emit(ProfileLoading());
    final response = await ProfileRepo.getUserProfile();
    response.when(
      success: (data) {
        profileModel = data;
        emit(ProfileSuccess(profileModel: data));
      },
      failure: (error) =>
          emit(ProfileError(error: error.apiErrorModel.message!)),
    );
  }
}
