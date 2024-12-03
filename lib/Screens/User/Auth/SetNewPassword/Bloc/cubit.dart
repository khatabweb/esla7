import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/Auth/SetNewPassword/Bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState>{
  UpdatePasswordCubit() : super(UpdatePasswordInitState());

  static UpdatePasswordCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  late String password, confirmPassword;

  Future<void> userUpdatePassword() async {
    emit(UpdatePasswordLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final phone = _pref.getString("phone");

      print("phone: $phone");
      print("password: $password");
      print("confirm password: $confirmPassword");

      FormData formData = FormData.fromMap({
        "phone" : phone,
        "password" : password,
        "confirm_password" : confirmPassword,
      });

      final Response response = await dio.post(ApiUtl.user_update_password, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        emit(UpdatePasswordSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: User Forget password state error ::::::::::::::");
        emit(UpdatePasswordErrorState(response.data["message"]));
      }
    }
    catch(e){
      print("::::::::::: User Forget password catch error :::::::::::::: ${e.toString()}");
      emit(UpdatePasswordErrorState(e.toString()));
    }
  }
}