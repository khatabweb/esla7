import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repo/accept_repo.dart';
import 'state.dart';

class AcceptCubit extends Cubit<AcceptState> {
  AcceptCubit() : super(AcceptInitState());

  static AcceptCubit get(context) => BlocProvider.of(context);

  Future<void> acceptOrder(int? orderId) async {
    emit(AcceptLoadingState());

    try {
      FormData formData = FormData.fromMap({
        "id": orderId,
        "action": "accept",
      });

      final response = await AcceptRepo.acceptOrder(formData: formData);

      response.when(
        success: (success) {
          emit(AcceptSuccessState());
        },
        failure: (failure) {
          emit(AcceptErrorState(failure.apiErrorModel.message!));
        },
      );
    } catch (e) {
      print("::::::::::: catch error :::::::::::::: ${e.toString()}");
      emit(AcceptErrorState(e.toString()));
    }
  }
}
