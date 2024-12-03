import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'state.dart';


class RateCubit extends Cubit<RateState>{
  RateCubit() : super(RateInitState());

  static RateCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  int? rate;
  int? ownerId;

  Future<void> rateOwner() async {
    emit(RateLoadingState());

    try{
      SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("user_token");
      final userId = _pref.getInt("user_id");

      print("Rate : $rate");
      print("user ID: $userId");
      print("owner ID: $ownerId");

      dio.options.headers = {
        "Authorization": "Bearer $token",
      };

      FormData formData = FormData.fromMap({
        "rate" : rate,
        "user_id" : userId,
        "owner_id" : ownerId,
      });

      final Response response = await dio.post(ApiUtl.user_rate, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        print("::::::::::: rate success ::::::::::::::");
        emit(RateSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: Rate error ::::::::::::::");
        emit(RateErrorState(response.data["message"]));
      }
    }catch(e){
      print("rate catch error :::::::::::::: ${e.toString()}");
      emit(RateErrorState(e.toString()));
    }
  }
}
