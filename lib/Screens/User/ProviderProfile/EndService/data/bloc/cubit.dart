import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/end_list_model.dart';
import '../model/model.dart';
import '../repo/user_end_list_repo.dart';
import 'state.dart';

class UserEndListCubit extends Cubit<UserEndListState> {
  UserEndListCubit() : super(UserEndListInitState());

  static UserEndListCubit get(context) => BlocProvider.of(context);

  late EndListModel endListModelCubit;
  List<CartItemModel> cartItemList = [];

  Future<void> userEndService(int? ownerId, int? serviceId) async {
    emit(UserEndListLoadingState());

    print("owner ID: $ownerId");
    print("Service ID: $serviceId");

    FormData formData = FormData.fromMap({
      "owner_id": ownerId,
      "service_id": serviceId,
    });

    final response = await UserEndListRepo.getUserEndList(formData: formData);

    response.when(
      success: (endListModel) {
        endListModelCubit = endListModel;
        print("endListModel: $endListModel");
        emit(UserEndListSuccessState(endListModel));
      },
      failure: (error) {
        emit(UserEndListErrorState(error.apiErrorModel.message!));
      },
    );
  }
}
