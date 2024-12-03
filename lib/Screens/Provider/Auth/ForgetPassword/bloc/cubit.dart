import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Provider/Auth/ForgetPassword/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerResetCubit extends Cubit<OwnerResetState>{
  OwnerResetCubit() : super(OwnerResetInitState());

  static OwnerResetCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  late String phone;

  Future<void> ownerResetPassword() async {
    emit(OwnerResetLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();

      print("phone: $phone");

      FormData formData = FormData.fromMap({
        "phone" : "966$phone",
      });

      final Response response = await dio.post(ApiUtl.owner_reset_password, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        _pref.setString("phone", response.data["phone"]);
        _pref.setInt("owner_id", response.data["owner_id"]);
        print(response.data);
        emit(OwnerResetSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print(":::::::: owner reset password state error :::::::::::");
        emit(OwnerResetErrorState(response.data["message"]));
      }
    }
    catch(e){
      print("User reset password catch error ::::::::: ${e.toString()}");
      emit(OwnerResetErrorState(e.toString()));
    }
  }
}