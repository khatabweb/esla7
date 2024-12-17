import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/service_name_model.dart';
import '../repo/service_name_list_repo.dart';
import 'state.dart';

class ServiceNameCubit extends Cubit<ServiceNameState> {
  ServiceNameCubit() : super(ServiceNameInitState());

  static ServiceNameCubit get(context) => BlocProvider.of(context);
  late ServiceNameModel serviceNameModel;
  int? serviceId;

  Future<void> ownerServiceName() async {
    emit(ServiceNameLoadingState());

    try {
      print("Service ID: $serviceId");

      FormData formData = FormData.fromMap({
        "id": serviceId,
      });

      final response =
          await ServiceNameListRepo.getServiceNameList(formData: formData);
      response.when(
          success: (responseData) {
            serviceNameModel = responseData;
            emit(ServiceNameSuccessState(responseData));
          },
          failure: (failure) =>
              emit(ServiceNameErrorState(failure.apiErrorModel.message!)));
    } catch (e) {
      print("::::::::::: Owner Details catch error ::::::::::::::");
      emit(ServiceNameErrorState(e.toString()));
    }
  }
}
