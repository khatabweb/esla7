import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/sub_service_model.dart';
import '../repo/sub_service_repo.dart';
import 'state.dart';

class SubServiceCubit extends Cubit<SubServiceState> {
  SubServiceCubit() : super(SubServiceInitState());

  static SubServiceCubit get(context) => BlocProvider.of(context);

  late SubServiceModel subServiceModel;

  Future<void> ownerSubService(int serviceId) async {
    emit(SubServiceLoadingState());

    try {
      print("Service ID: $serviceId");

      FormData formData = FormData.fromMap({
        "id": serviceId,
      });

      final response = await SubServiceRepo.ownerSubService(
        formData: formData,
      );
      response.when(success: (responseData) {
        subServiceModel = responseData;
        emit(SubServiceSuccessState(responseData));
      }, failure: (failure) {
        emit(SubServiceErrorState(failure.apiErrorModel.message!));
      });
    } catch (e) {
      print("::::::::::: Owner Details catch error ::::::::::::::");
      emit(SubServiceErrorState(e.toString()));
    }
  }
}
