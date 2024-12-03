import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/Auth/Login/Bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  GetStorage box =GetStorage();
  String? phone, password;

  Future<void> userLogin() async {
    emit(LoginLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      print("phone: $phone");
      print("password: $password");

      FormData formData = FormData.fromMap({
        "phone" : "966$phone",
        "password" : password,
        "google_token": _pref.getString("user_google_token"),
      });

      final Response response = await dio.post(ApiUtl.user_login, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        _pref.setString("user_token", response.data["access_token"]);
        _pref.setString("user_name", response.data["name"]);
        _pref.setInt("user_id", response.data["user_id"]);
        box.write("id", response.data["user_id"]);
        box.write("type", response.data["type"]);
        _pref.setString("type", response.data["type"]);
        print(response.data);
        emit(LoginSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: User Login error ::::::::::::::");
        emit(LoginErrorState(response.data["message"]));
      }
    }catch(e){
      print("::::::::::: User Login catch error ::::::::::::::");
      emit(LoginErrorState(e.toString()));
    }
  }
}