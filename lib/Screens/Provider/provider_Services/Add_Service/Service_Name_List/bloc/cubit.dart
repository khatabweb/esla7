import 'package:dio/dio.dart';
import '../../../../../../API/api_utility.dart';
import '../../../../../Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';
import 'state.dart';

class ServiceNameCubit extends Cubit<ServiceNameState> {
  ServiceNameCubit() : super(ServiceNameInitState());

  static ServiceNameCubit get(context) => BlocProvider.of(context);
  // Dio dio = Dio();
  int? serviceId;
  ServiceNameModel serviceNameModel = ServiceNameModel();
  bool? isLoading;

  Future<void> ownerServiceName() async {
    emit(ServiceNameLoadingState());
    isLoading = true;

    try {
      print("Service ID: $serviceId");

      FormData formData = FormData.fromMap({
        "id": serviceId,
      });

      final Response response = await NetworkHelper()
          .request(ApiUtl.owner_end_service, body: formData);

      if (response.statusCode == 200 && response.data["status"] == "success") {
        print(response.data);
        serviceNameModel = ServiceNameModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(ServiceNameSuccessState());
        isLoading = false;
      } else if (response.statusCode == 200 &&
          response.data["status"] != "success") {
        print("::::::::::: Owner Details error ::::::::::::::");
        emit(ServiceNameErrorState(response.data["message"]));
      }
    } catch (e) {
      print("::::::::::: Owner Details catch error ::::::::::::::");
      emit(ServiceNameErrorState(e.toString()));
    }
  }
}
