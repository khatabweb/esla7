import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class AddServiceCubit extends Cubit<AddServiceState>{
  AddServiceCubit() : super(AddServiceInitState());

  static AddServiceCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  int? subServiceId;
  int? serviceNameId;
  int? price;
  String? desc;

  Future<void> ownerAddService() async {
    emit(AddServiceLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("owner_token");
      final ownerId = _pref.getInt("owner_id");

      print("Owner ID: $ownerId");
      print("Sub service ID: $subServiceId");
      print("End service ID: $serviceNameId");
      print("Price: $price");
      print("Description: $desc");

      dio.options.headers = ({
        "Authorization": "Bearer $token",
      });

      FormData formData = FormData.fromMap({
        "owner_id" : ownerId,
        "sub_service_id" : subServiceId,
        "end_service_id" : serviceNameId,
        "price" : price,
        "description" : desc,
      });

      final Response response = await dio.post(ApiUtl.owner_add_service, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(AddServiceSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: State error ::::::::::::::");
        emit(AddServiceErrorState(response.data["message"]));
      }
    }catch(e){
      print("::::::::::: catch error :::::::::::::: ${e.toString()}");
      emit(AddServiceErrorState(e.toString()));
    }
  }
}