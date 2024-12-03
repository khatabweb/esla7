import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/Auth/ForgetPassword/Bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserResetCubit extends Cubit<ForgetState>{
  UserResetCubit() : super(ForgetInitState());

  static UserResetCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  late String phone;

  Future<void> userResetPassword() async {
    emit(ForgetLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();

      print("phone: $phone");

      FormData formData = FormData.fromMap({
        "phone" : "966$phone",
      });

      final Response response = await dio.post(ApiUtl.user_reset_password, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        _pref.setString("phone", response.data["phone"]);
        _pref.setInt("user_id", response.data["user_id"]);
        print(response.data);
        emit(ForgetSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: User Forget password state error ::::::::::::::");
        emit(ForgetErrorState(response.data["message"]));
      }
    }
    catch(e){
      print("::::::::::: User Forget password catch error :::::::::::::: ${e.toString()}");
      emit(ForgetErrorState(e.toString()));
    }
  }
}