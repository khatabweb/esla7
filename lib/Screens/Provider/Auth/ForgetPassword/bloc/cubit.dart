import 'package:dio/dio.dart';
import '../../../../../API/api_utility.dart';
import 'state.dart';
import '../../../../Widgets/helper/cach_helper.dart';
import '../../../../Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerResetCubit extends Cubit<OwnerResetState> {
  OwnerResetCubit() : super(OwnerResetInitState());

  static OwnerResetCubit get(context) => BlocProvider.of(context);
  // Dio dio = Dio();
  late String phone;

  Future<void> ownerResetPassword() async {
    emit(OwnerResetLoadingState());

    try {
      print("phone: $phone");

      FormData formData = FormData.fromMap({
        "phone": "966$phone",
      });

      // final Response response = await dio.post(ApiUtl.owner_reset_password, data: formData);
      final Response response = await NetworkHelper().request(
          ApiUtl.owner_reset_password,
          method: ServerMethods.POST,
          body: formData);

      if (response.statusCode == 200 && response.data["status"] == "success") {
        CacheHelper.instance!.setData("phone", value: response.data["phone"]);
        CacheHelper.instance!
            .setData("owner_id", value: response.data["owner_id"]);
        print(response.data);
        emit(OwnerResetSuccessState());
      } else if (response.statusCode == 200 &&
          response.data["status"] != "success") {
        print(":::::::: owner reset password state error :::::::::::");
        emit(OwnerResetErrorState(response.data["message"]));
      }
    } catch (e) {
      print("User reset password catch error ::::::::: ${e.toString()}");
      emit(OwnerResetErrorState(e.toString()));
    }
  }
}
