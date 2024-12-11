import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/model.dart';
import '../repo/user_sub_list_repo.dart';
import 'state.dart';

/// the same cubit and request in "lib\Screens\Provider\Provider_Services"
class UserSubListCubit extends Cubit<UserSubListState> {
  UserSubListCubit() : super(UserSubListInitState());
  late SubListModel subListModel;

  Future<void> userSubService({required int ownerId}) async {
    emit(UserSubListLoadingState());

    print("Owner ID: $ownerId");
    FormData formData = FormData.fromMap({
      "owner_id": ownerId,
    });

    final response = await UserSubListRepo.getUserSubList(formData: formData);
    response.when(
      success: (success) {
        subListModel = success;
        emit(UserSubListSuccessState(subListModel));
      },
      failure: (failure) =>
          emit(UserSubListErrorState(failure.apiErrorModel.message!)),
    );
  }
}
