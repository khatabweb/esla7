import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/User/Auth/ConfirmCode/Bloc/state.dart';
// import 'package:esla7/Screens/Widgets/helper/app_storg.dart';
import 'package:esla7/Screens/Widgets/helper/cach_helper.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ConfirmCodeCubit extends Cubit<ConfirmCodeState> {
  ConfirmCodeCubit() : super(ConfirmCodeInitState());

  static ConfirmCodeCubit get(context) => BlocProvider.of(context);
  String? code;
  bool? loading;

  Future<void> confirmCodeCubit() async {
    loading = true;
    emit(ConfirmCodeLoadingState());

    try {
      print("confirm code : $code");
      // SharedPreferences _pref = await SharedPreferences.getInstance();
      // final userID = _pref.getInt("user_id");
      final userID = CacheHelper.instance!
          .getData(key: "user_id", valueType: ValueType.int);

      GetStorage box = GetStorage();

      FormData formData = FormData.fromMap({
        "user_id": box.read("id"),
        "code": code,
      });

      // final Response response = await dio.post(ApiUtl.user_verify_code, data: formData);
      final Response response = await NetworkHelper().request(
          ApiUtl.user_verify_code,
          body: formData,
          method: ServerMethods.POST);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["status"] == "Success") {
        print(response.data);
        emit(ConfirmCodeSuccessState());
      } else if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data["status"] != "Success") {
        print("::::::::::: confirm code error ::::::::::::::");
        emit(ConfirmCodeErrorState(response.data["message"]));
      }
    } catch (e) {
      print("::::::::::: confirm code Catch error ::::::::::::::");
      emit(ConfirmCodeErrorState(e.toString()));
    }
  }
}
