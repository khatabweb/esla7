import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class DeleteServiceCubit extends Cubit<DeleteServiceState>{
  DeleteServiceCubit() : super(DeleteServiceInitState());

  static DeleteServiceCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();

  Future<void> deleteService(int? endServiceId) async {
    emit(DeleteServiceLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();

      print("end service id : $endServiceId");

      dio.options.headers = {
        "Authorization" : "Bearer ${_pref.getString("owner_token")}",
      };

      final Response response = await dio.post("${ApiUtl.owner_delete_end_service}$endServiceId",);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        emit(DeleteServiceSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("error ::::::::::::::${response.data["message"]}");
        emit(DeleteServiceErrorState(response.data["message"]));
      }
    }catch(e){
      print("catch error :::::::: ${e.toString()}");
      emit(DeleteServiceErrorState(e.toString()));
    }
  }
}