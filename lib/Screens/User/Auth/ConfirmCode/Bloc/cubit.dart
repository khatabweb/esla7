import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/Auth/ConfirmCode/Bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmCodeCubit extends Cubit<ConfirmCodeState>{
  ConfirmCodeCubit() : super(ConfirmCodeInitState());

  static ConfirmCodeCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? code;
  bool? loading;

  Future<void> confirmCodeCubit() async {
    loading = true;
    emit(ConfirmCodeLoadingState());

    try{
      print("confirm code : $code");
      SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("user_token");
      final userID = _pref.getInt("user_id");

      dio.options.headers = {
        "Authorization" : "Bearer $token",
      };

      FormData formData = FormData.fromMap({
        "user_id" : userID,
        "code" : code,
      });

      final Response response = await dio.post(ApiUtl.user_verify_code, data: formData);

      if((response.statusCode == 200 || response.statusCode == 201) && response.data["status"] == "Success"){
        print(response.data);
        emit(ConfirmCodeSuccessState());
      }else if((response.statusCode == 200 || response.statusCode == 201) && response.data["status"] != "Success"){
        print("::::::::::: confirm code error ::::::::::::::");
        emit(ConfirmCodeErrorState(response.data["message"]));
      }
    }catch(e){
      print("::::::::::: confirm code Catch error ::::::::::::::");
      emit(ConfirmCodeErrorState(e.toString()));
    }
  }
}