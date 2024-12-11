import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../../API/api_utility.dart';
import 'state.dart';
// import 'package:esla7/Screens/Widgets/helper/app_storg.dart';
import 'package:esla7/Screens/Widgets/helper/cache_helper.dart';
import 'package:esla7/Screens/Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      final userID = CacheHelper.instance!
          .getData(key: "user_id", valueType: ValueType.int);

      log("message confirm code : $userID");
      FormData formData = FormData.fromMap({
        "user_id": userID,
        "code": code,
      });

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
