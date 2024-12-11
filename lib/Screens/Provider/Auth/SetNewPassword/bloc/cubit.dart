import 'package:dio/dio.dart';
import '../../../../../API/api_utility.dart';
import 'state.dart';
import '../../../../Widgets/helper/cache_helper.dart';
import '../../../../Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerUpdatePassCubit extends Cubit<OwnerUpdatePassState> {
  OwnerUpdatePassCubit() : super(OwnerUpdatePassInitState());

  static OwnerUpdatePassCubit get(context) => BlocProvider.of(context);
  late String password, confirmPassword;

  Future<void> ownerUpdatePassword() async {
    emit(OwnerUpdatePassLoadingState());

    try {
      final phone = CacheHelper.instance!
          .getData(key: "phone", valueType: ValueType.string);

      print("phone: $phone");
      print("password: $password");
      print("confirm password: $confirmPassword");

      FormData formData = FormData.fromMap({
        "phone": phone,
        "password": password,
        "confirm_password": confirmPassword,
      });

      final Response response = await NetworkHelper().request(
          ApiUtl.owner_update_password,
          body: formData,
          method: ServerMethods.POST);

      if (response.statusCode == 200 && response.data["status"] == "success") {
        print(response.data);
        emit(OwnerUpdatePassSuccessState());
      } else if (response.statusCode == 200 &&
          response.data["status"] != "success") {
        print("::::::::::: User Forget password state error ::::::::::::::");
        emit(OwnerUpdatePassErrorState(response.data["message"]));
      }
    } catch (e) {
      print(
          "::::::::::: User Forget password catch error :::::::::::::: ${e.toString()}");
      emit(OwnerUpdatePassErrorState(e.toString()));
    }
  }
}
