import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/refuse_repo.dart';
import 'state.dart';

class RefuseCubit extends Cubit<RefuseState> {
  RefuseCubit() : super(RefuseInitState());

  static RefuseCubit get(context) => BlocProvider.of(context);

  Future<void> refuseOrder(int? orderId) async {
    emit(RefuseLoadingState());

    try {
      FormData formData = FormData.fromMap({
        "id": orderId,
        "action": "finished",
      });
      final response = await RefuseRepo.refuseOrder(formData: formData);
      response.when(
        success: (response) => emit(RefuseSuccessState()),
        failure: (error) => emit(
          RefuseErrorState(error.apiErrorModel.message!),
        ),
      );
    } catch (e) {
      print("::::::::::: catch error :::::::::::::: ${e.toString()}");
      emit(RefuseErrorState(e.toString()));
    }
  }
}
