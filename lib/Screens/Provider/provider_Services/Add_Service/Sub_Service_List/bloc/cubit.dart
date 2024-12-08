import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../../API/api_utility.dart';
import '../../../../../Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';
import 'state.dart';

class SubServiceCubit extends Cubit<SubServiceState> {
  SubServiceCubit() : super(SubServiceInitState());

  static SubServiceCubit get(context) => BlocProvider.of(context);
  // Dio dio = Dio();
  int? serviceId;
  SubServiceModel subServiceModel = SubServiceModel();
  bool? isLoading;

  Future<void> ownerSubService() async {
    emit(SubServiceLoadingState());
    isLoading = true;

    try {
      print("Service ID: $serviceId");

      FormData formData = FormData.fromMap({
        "id": serviceId,
      });

      final Response response = await NetworkHelper().request(
        ApiUtl.owner_sub_service,
        body: formData,
        method: ServerMethods.POST,
      );

      if (response.statusCode == 200 && response.data["status"] == "success") {
        print(response.data);
        subServiceModel = SubServiceModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(SubServiceSuccessState());
        isLoading = false;
      } else if (response.statusCode == 200 &&
          response.data["status"] != "success") {
        print("::::::::::: Owner Details error ::::::::::::::");
        emit(SubServiceErrorState(response.data["message"]));
      }
    } catch (e) {
      print("::::::::::: Owner Details catch error ::::::::::::::");
      emit(SubServiceErrorState(e.toString()));
    }
  }
}
