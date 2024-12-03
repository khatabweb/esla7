import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Provider/Auth/ConfirmCode/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerVerifyCubit extends Cubit<OwnerVerifyState>{
  OwnerVerifyCubit() : super(OwnerVerifyInitState());

  static OwnerVerifyCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? code;

  Future<void> ownerVerify() async {
    emit(OwnerVerifyLoadingState());

    try{
      print("confirm code : $code");
      SharedPreferences _pref = await SharedPreferences.getInstance();
      final ownerId = _pref.getInt("owner_id");

      FormData formData = FormData.fromMap({
        "owner_id" : ownerId,
        "code" : code,
      });

      final Response response = await dio.post(ApiUtl.owner_verify, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        emit(OwnerVerifySuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: owner Verify error ::::::::::::::");
        emit(OwnerVerifyErrorState(response.data["message"]));
      }

    }catch(e){
      print("owner Verify Catch error :::::::::: ${e.toString()}");
      emit(OwnerVerifyErrorState(e.toString()));
    }
  }
}