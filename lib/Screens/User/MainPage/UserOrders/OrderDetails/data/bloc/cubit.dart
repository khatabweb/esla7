import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/user_order_details_repo.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../model/model.dart';
import 'state.dart';

class UserOrderDetailsCubit extends Cubit<UserOrderDetailsState> {
  UserOrderDetailsCubit() : super(UserOrderDetailsInitState());

  static UserOrderDetailsCubit get(context) => BlocProvider.of(context);
  int? orderId;
  late UserOrderDetailsModel userOrderDetailsModel;

  Future<void> orderDetails() async {
    emit(UserOrderDetailsLoadingState());
    try {
      FormData formData = FormData.fromMap({
        "id": orderId,
      });

      final response =
          await UserOrderDetailsRepo.orderDetails(formData: formData);

      response.when(success: (response) {
        userOrderDetailsModel = response;
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(UserOrderDetailsSuccessState(userOrderDetailsModel));
      }, failure: (e) {
        emit(UserOrderDetailsErrorState(e.apiErrorModel.message!));
      });
    } catch (e) {
      print(
          "::::::::::: order Details catch error ::::::::::::::${e.toString()}");
      emit(UserOrderDetailsErrorState(e.toString()));
    }
  }
}
