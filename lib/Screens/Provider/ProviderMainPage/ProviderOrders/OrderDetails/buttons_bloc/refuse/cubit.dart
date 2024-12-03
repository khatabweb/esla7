import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class RefuseCubit extends Cubit<RefuseState>{
  RefuseCubit() : super(RefuseInitState());

  static RefuseCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();

  Future<void> refuseOrder(int? orderId) async {
    emit(RefuseLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("owner_token");

      print("order ID: $orderId");

      dio.options.headers = ({
        "Authorization": "Bearer $token",
      });

      FormData formData = FormData.fromMap({
        "id" : orderId,
        "action" : "finished",
      });

      final Response response = await dio.post(ApiUtl.owner_refuse_order, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(RefuseSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: State error ::::::::::::::");
        emit(RefuseErrorState(response.data["message"]));
      }
    }catch(e){
      print("::::::::::: catch error :::::::::::::: ${e.toString()}");
      emit(RefuseErrorState(e.toString()));
    }
  }
}