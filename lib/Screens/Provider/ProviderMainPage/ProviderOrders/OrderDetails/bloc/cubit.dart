import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../../API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';
import 'state.dart';

class OwnerOrderDetailsCubit extends Cubit<OwnerOrderDetailsState>{
  OwnerOrderDetailsCubit() : super(OwnerOrderDetailsInitState());

  static OwnerOrderDetailsCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  int? orderId;
  OwnerOrderDetailsModel model = OwnerOrderDetailsModel();

  Future<void> orderDetails() async {
    emit(OwnerOrderDetailsLoadingState());

    try{
      print("order ID: $orderId");

      SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("owner_token");

      dio.options.headers = {
        "Authorization": "Bearer $token",
      };

      FormData formData = FormData.fromMap({
        "id" : orderId,
      });

      final Response response = await dio.post(ApiUtl.owner_order_details, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        model = OwnerOrderDetailsModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(OwnerOrderDetailsSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: Owner Details error ::::::::::::::");
        emit(OwnerOrderDetailsErrorState(response.data["status"]));
      }
    }catch(e){
      print("::::::::::: order Details catch error ::::::::::::::${e.toString()}");
      emit(OwnerOrderDetailsErrorState(e.toString()));
    }
  }
}
