import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/Profile/EditProfile/bloc/model.dart';
import 'package:esla7/Screens/User/Profile/EditProfile/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserUpdateCubit extends Cubit<UserUpdateState>{
  UserUpdateCubit() : super(UserUpdateInitState());

  static UserUpdateCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? name, phone, email, password;
  XFile? image;
  UserUpdateModel userModel = UserUpdateModel();

  Future<void> userUpdate() async {
    emit(UserUpdateLoadingState());
    // isLoading = true;

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("user_token");
      final userID = _pref.getInt("user_id");

      print("user ID ::::: $userID");
      print("name ::::: $name");
      print("phone :::::: $phone");
      print("email :::::: $email");
      print("password :::::: $password");

      dio.options.headers = {
        "Authorization" : "Bearer $token",
      };

      FormData formData = FormData.fromMap({
        "name" : name,
        "phone" : phone,
        "email" : email,
        "password" : password,
        if(image!=null)
        "image" : await MultipartFile.fromFile(image!.path),
      });

      final Response response = await dio.post("${ApiUtl.user_update_data}$userID", data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        userModel = UserUpdateModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(UserUpdateSuccessState());
        // isLoading = false;
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: Owner Details error ::::::::::::::");
        emit(UserUpdateErrorState(response.data["message"]));
      }
    }catch(e){
      print("Owner Details catch error :::::::::::::: ${e.toString()}");
      emit(UserUpdateErrorState(e.toString()));
    }
  }
}