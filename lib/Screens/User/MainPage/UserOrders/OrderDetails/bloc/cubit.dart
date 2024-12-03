import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';
import 'state.dart';

class UserOrderDetailsCubit extends Cubit<UserOrderDetailsState>{
  UserOrderDetailsCubit() : super(UserOrderDetailsInitState());

  static UserOrderDetailsCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  int? orderId;
  UserOrderDetailsModel model = UserOrderDetailsModel();

  Future<void> orderDetails() async {
    emit(UserOrderDetailsLoadingState());

    try{
      print("order ID: $orderId");

      SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("user_token");

      dio.options.headers = {
        "Authorization": "Bearer $token",
      };

      FormData formData = FormData.fromMap({
        "id" : orderId,
      });

      final Response response = await dio.post(ApiUtl.user_order_details, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        model = UserOrderDetailsModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(UserOrderDetailsSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: Order Details error ::::::::::::::");
        emit(UserOrderDetailsErrorState(response.data["status"]));
      }
    }catch(e){
      print("::::::::::: order Details catch error ::::::::::::::${e.toString()}");
      emit(UserOrderDetailsErrorState(e.toString()));
    }
  }
}
