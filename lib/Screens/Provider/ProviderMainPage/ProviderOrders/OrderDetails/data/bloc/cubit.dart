import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/owner_order_details_model.dart';
import '../repo/owner_order_details_repo.dart';
import 'state.dart';

class OwnerOrderDetailsCubit extends Cubit<OwnerOrderDetailsState> {
  OwnerOrderDetailsCubit() : super(OwnerOrderDetailsInitState());

  static OwnerOrderDetailsCubit get(context) => BlocProvider.of(context);
  int? orderId;
  late OwnerOrderDetailsModel model;

  Future<void> orderDetails() async {
    emit(OwnerOrderDetailsLoadingState());

    try {
      FormData formData = FormData.fromMap({
        "id": orderId,
      });

      final response =
          await OwnerOrderDetailsRepo.getOwnerOrderDetails(formData: formData);

      response.when(success: (responseData) {
        model = responseData;
        emit(OwnerOrderDetailsSuccessState());
      }, failure: (error) {
        emit(OwnerOrderDetailsErrorState(error.apiErrorModel.message!));
      });
    } catch (e) {
      print(
          "::::::::::: order Details catch error ::::::::::::::${e.toString()}");
      emit(OwnerOrderDetailsErrorState(e.toString()));
    }
  }
}
