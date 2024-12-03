import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Provider/Auth/Login/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerLoginCubit extends Cubit<OwnerLoginState>{
  OwnerLoginCubit() : super(OwnerLoginInitState());

  static OwnerLoginCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  GetStorage box =GetStorage();
  String? phone, password;

  Future<void> ownerLogin() async {
    emit(OwnerLoginLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();

      print("phone: $phone");
      print("password: $password");

      FormData formData = FormData.fromMap({
        "phone" : "966$phone",
        "password" : password,
        "google_token" : _pref.getString("owner_google_token"),
      });

      final Response response = await dio.post(ApiUtl.owner_login, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        _pref.setString("owner_token", response.data["access_token"]);
        _pref.setInt("owner_id", response.data["owner_id"]);
        box.write("owner_id", response.data["owner_id"]);
        print(response.data["owner_id"]);
        _pref.setString("type", response.data["type"]);
        print(response.data);
        emit(OwnerLoginSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: owner Login error ::::::::::::::");
        emit(OwnerLoginErrorState(response.data["message"]));
      }else if(response.statusCode == 200 && response.data["error"] == "check your data"){
        print("::::::::::: owner Login error ::::::::::::::");
        emit(OwnerLoginErrorState(response.data["error"]));
      }
    }catch(e){
      print("owner Login catch error :::::::: ${e.toString()}");
      emit(OwnerLoginErrorState(e.toString()));
    }
  }
}