import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Provider/Auth/SetNewPassword/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerUpdatePassCubit extends Cubit<OwnerUpdatePassState>{
  OwnerUpdatePassCubit() : super(OwnerUpdatePassInitState());

  static OwnerUpdatePassCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  late String password, confirmPassword;

  Future<void> ownerUpdatePassword() async {
    emit(OwnerUpdatePassLoadingState());

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

      final Response response = await dio.post(ApiUtl.owner_update_password, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        emit(OwnerUpdatePassSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: User Forget password state error ::::::::::::::");
        emit(OwnerUpdatePassErrorState(response.data["message"]));
      }
    }
    catch(e){
      print("::::::::::: User Forget password catch error :::::::::::::: ${e.toString()}");
      emit(OwnerUpdatePassErrorState(e.toString()));
    }
  }
}