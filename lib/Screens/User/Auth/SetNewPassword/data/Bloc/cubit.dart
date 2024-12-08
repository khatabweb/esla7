import 'package:dio/dio.dart';
import 'package:esla7/Screens/User/Auth/SetNewPassword/data/repo/update_password_repo.dart';
import 'package:esla7/Screens/Widgets/helper/cach_helper.dart';
import 'state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(UpdatePasswordInitState());

  static UpdatePasswordCubit get(context) => BlocProvider.of(context);

  late String password, confirmPassword;

  Future<void> userUpdatePassword() async {
    emit(UpdatePasswordLoadingState());

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

    final response =
        await UpdatePasswordRepo.updatePassword(formData: formData);

    response.when(
      success: (data) {
        print(data);
        emit(UpdatePasswordSuccessState());
      },
      failure: (error) {
        print(error);
        emit(UpdatePasswordErrorState(error.toString()));
      },
    );
  }
}
