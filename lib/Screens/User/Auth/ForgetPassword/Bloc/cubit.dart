import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../API/api_utility.dart';
import 'state.dart';
import '../../../../Widgets/helper/cache_helper.dart';
import '../../../../Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserResetCubit extends Cubit<ForgetState> {
  UserResetCubit() : super(ForgetInitState());

  static UserResetCubit get(context) => BlocProvider.of(context);

  late String phone;

  Future<void> userResetPassword() async {
    emit(ForgetLoadingState());

    try {
      print("phone: $phone");

      FormData formData = FormData.fromMap({
        "phone": "966$phone",
      });

      final Response response = await NetworkHelper().request(
          ApiUtl.user_reset_password,
          body: formData,
          method: ServerMethods.POST);

      if (response.statusCode == 200 && response.data["status"] == "success") {
        CacheHelper.instance!
            .setData("phone", value: response.data["phone"] as String);
        CacheHelper.instance!
            .setData("user_id", value: response.data["user_id"] as int);
        print(response.data);
        emit(ForgetSuccessState());
      } else if (response.statusCode == 200 &&
          response.data["status"] != "success") {
        print("::::::::::: User Forget password state error ::::::::::::::");
        emit(ForgetErrorState(response.data["message"]));
      }
    } catch (e) {
      print(
          "::::::::::: User Forget password catch error :::::::::::::: ${e.toString()}");
      emit(ForgetErrorState(e.toString()));
    }
  }
}
