import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/Auth/SignUp/Bloc/state.dart';
import 'package:esla7/Screens/Widgets/helper/cach_helper.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  GetStorage box = GetStorage();
  String? phone, name, email, password, confirmPassword;

  Future<void> userSignUp() async {
    emit(SignUpLoadingState());

    try {
      final googleToken = CacheHelper.instance!.getData(key:"user_google_token",valueType: ValueType.string);
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

      final Response response = await NetworkHelper().request(
          ApiUtl.user_register,
          body: formData,
          method: ServerMethods.POST);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["status"] == "success") {
        emit(SignUpSuccessState());
      } else if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["status"] != "success") {
        CacheHelper.instance!.setData("user_token",
            value: response.data["access_token"] as String);
        CacheHelper.instance!.setData(
          "user_id",
          value: response.data["user_id"] as int,
        );


        log("user id : ${response.data["user_id"]}");
        log("CacheHelper user id : ${CacheHelper.instance!.getData(key: "user_id", valueType: ValueType.int)}");

        // box.write("id", response.data["user_id"]);
        box.write("type", response.data["type"]);
        CacheHelper.instance!
            .setData("type", value: response.data["type"] as String);
        print("::::::::::: User Sign up error ::::::::::::::");
        emit(SignUpErrorState(response.data["message"]));
      }
    } catch (e) {
      log(e.toString());

      emit(SignUpErrorState(e.toString()));
    }
  }

  // _saveModel(SharedPreferences _pref, Response response) {
  //   _pref.setString("user_token", response.data["access_token"]);
  //   _pref.setInt("user_id", response.data["user_id"]);
  //   // _pref.setString("user_name", response.data["name"]);
  //   box.write("id", response.data["user_id"]);
  //   box.write("type", response.data["type"]);
  //   _pref.setString("type", response.data["type"]);
  // }
}



// {
//               "status": "success",
//               "message": "Must verfiy your account!",
//               "user_id": 67,
//               "type": "user",
//               "phone": "966123456789",
//               "google_token": "dOtOASsiRd2JAvjUrwBXkz:APA91bEwGAT6MD_wo_nxfeFkREUNvZz5AQfLUSfzNKwG3I0q6SfshVcOYEGTN08BQMpNAnm-d9_FyYwz443NcogZG294kEqSXdv2kom4O06sfVEmKnGLtyw",
//               "code": 7814,
//               "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNTI3YWY3MjBkYTllYjlmNzQ3NWY2NDNhOTlhZDE5OGExYTU3MDU3ODAyNjBiN2Y0MDMzZjljOGEwZTRhOWFjOTdlYWMyZmJkYTdmZDhiMDQiLCJpYXQiOjE3MzMyMTgxNzIsIm5iZiI6MTczMzIxODE3MiwiZXhwIjoxNzY0NzU0MTcyLCJzdWIiOiI2NyIsInNjb3BlcyI6W119.LgaIIQmtUGuTn9XNafromm0KrOy8bMvEZ0NsBiNAclXauARVk91fgxupbyAoBG4ZlXdk3n2U_wDPkA7DfruUUlyXcGC7JiL5SOJ_zVckAJRtZFf680zmf6KHGj9kf-ylZMNIWIGHo0fl3yiY1n606mE6SkNqwe48xMc5mhrF58OnKetsfNFUFQB3tTl0WqCbdvwCI_B96voEFAwYEGE9jjWtarE_I6zK0ZbeDC9rFAfmDTGT00O4gmkNBPMocxkYIuGPgOW_5nfuNsXLhms5wia3NFRf7GFVHVFkRFIMMlcXhEqUx_jgrRaJTf8u_uwDZ2yD4J7qjCx43_-69EjXFt5LK2i1cFpFiJOmqkQHq15hckojcJCW4kFEtF8zTA3CMnkIccU0qSTttothGA2U2x0NIdBon9SYqp1PR3kI6KyRh3LCY2eWShjkFIpqmxs4agDD8DZnYijmmdd84SIAVdbOuYt6JtZofph2o2v9IuEH8yyZsE9Svj23VBUeReJ7iACDiw1LK58GB292Vx7-slWF53RzMCC_-7w2gfKyEGUJyn9CcX9H1L27ETKM3M3hTklsXO77kAjFlLFoMTiTCrQSgz7G7QZSCuAXHCIwwkIkd6vWrBUcmdws4l5ASx20mdDlaYyBydzETEzzEISrYyeZO3gIyunXPbvavG9AvIg",
//               "token_type": "Bearer",
//               "expires_at": "2025-12-03 09:29:32"
//       }