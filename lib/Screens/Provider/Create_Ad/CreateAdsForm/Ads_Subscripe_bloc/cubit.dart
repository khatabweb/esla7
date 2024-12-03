import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class AdsSubscribeCubit extends Cubit<AdsSubscribeState>{
  AdsSubscribeCubit() : super(AdsSubscribeInitState());

  static AdsSubscribeCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  int? packageId;

  Future<void> subscribe() async {
    emit(AdsSubscribeLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final ownerId = _pref.getInt("owner_id");

      print("Owner ID: $ownerId");
      print("Package ID: $packageId");

      FormData formData = FormData.fromMap({
        "owner_id" : ownerId,
        "package_id" : packageId,
      });

      final Response response = await dio.post(ApiUtl.owner_ads_subscribe, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(AdsSubscribeSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: State error ::::::::::::::");
        emit(AdsSubscribeErrorState(response.data["message"]));
      }
    }catch(e){
      print("::::::::::: catch error :::::::::::::: ${e.toString()}");
      emit(AdsSubscribeErrorState(e.toString()));
    }
  }
}