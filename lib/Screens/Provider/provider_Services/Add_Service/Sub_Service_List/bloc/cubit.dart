import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';
import 'state.dart';

class SubServiceCubit extends Cubit<SubServiceState>{
  SubServiceCubit() : super(SubServiceInitState());

  static SubServiceCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  int? serviceId;
  SubServiceModel subServiceModel = SubServiceModel();
  bool? isLoading;

  Future<void> ownerSubService() async {
    emit(SubServiceLoadingState());
    isLoading = true;

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("owner_token");

      print("Service ID: $serviceId");

      dio.options.headers = ({
        "Authorization": "Bearer $token",
      });

      FormData formData = FormData.fromMap({
        "id" : serviceId,
      });

      final Response response = await dio.post(ApiUtl.owner_sub_service, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        subServiceModel = SubServiceModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(SubServiceSuccessState());
        isLoading = false;
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: Owner Details error ::::::::::::::");
        emit(SubServiceErrorState(response.data["message"]));
      }
    }catch(e){
      print("::::::::::: Owner Details catch error ::::::::::::::");
      emit(SubServiceErrorState(e.toString()));
    }
  }
}