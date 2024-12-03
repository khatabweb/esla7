import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/Auth/SignUp/Bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  GetStorage box = GetStorage();
  String? phone, name, email, password, confirmPassword;

  Future<void> userSignUp() async {
    emit(SignUpLoadingState());

    try {
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final googleToken = _pref.getString("user_google_token");
      print("phone: $phone");
      print("name: $name");
      print("email: $email");
      print("password: $password");
      print("confirm password: $confirmPassword");
      print("google Token: $googleToken");

      FormData formData = FormData.fromMap({
        "phone": "966$phone",
        "name": name,
        "email": email,
        "password": password,
        "confirm_password": confirmPassword,
        "google_token": googleToken,
      });

      final Response response =
          await dio.post(ApiUtl.user_register, data: formData);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["status"] == "success") {
        _pref.setString("user_token", response.data["access_token"]);
        _pref.setInt("user_id", response.data["user_id"]);
        _pref.setString("user_name", response.data["name"]);
        box.write("id", response.data["user_id"]);
        box.write("type", response.data["type"]);
        _pref.setString("type", response.data["type"]);
        print(response.data);
        emit(SignUpSuccessState());
      } else if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["status"] != "success") {
        print("::::::::::: User Sign up error ::::::::::::::");
        emit(SignUpErrorState(response.data["message"]));
      }
    } catch (e) {
      log(e.toString());
      
      emit(SignUpErrorState(e.toString()));
    }
  }
}
