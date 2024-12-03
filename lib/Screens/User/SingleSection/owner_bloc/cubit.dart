import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';
import 'state.dart';

class OwnersCubit extends Cubit<OwnersState>{
  OwnersCubit() : super(OwnersInitState());

  static OwnersCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  OwnerModel ownersModel = OwnerModel();

  Future<void> getOwners(int? serviceId) async {
    emit(OwnersLoadingState());

    try{
      print("Service ID ::::: $serviceId");

      FormData formData = FormData.fromMap({
        "id" : serviceId,
      });

      final Response response = await dio.post(ApiUtl.owners_list, data: formData);

      if(response.statusCode == 200 && response.data["message"] == "success"){
        print(response.data);
        ownersModel = OwnerModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(OwnersSuccessState());
      }else if(response.statusCode == 200 && response.data["message"] != "success"){
        print("Owners error ::::::::::::::${response.data["message"]}");
        emit(OwnersErrorState(response.data["message"]));
      }
    }catch(e){
      print("Owners catch error :::::::::::::: ${e.toString()}");
      emit(OwnersErrorState(e.toString()));
    }
  }
}