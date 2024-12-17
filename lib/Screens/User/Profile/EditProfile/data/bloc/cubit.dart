import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/local_storge/cache_helper.dart';
import '../model/model.dart';
import '../repo/user_update_repo.dart';
import 'state.dart';

class UserUpdateCubit extends Cubit<UserUpdateState> {
  UserUpdateCubit() : super(UserUpdateInitState());

  static UserUpdateCubit get(context) => BlocProvider.of(context);
  String? name, phone, email, password;
  XFile? image;
  late UserUpdateModel userModel;

  Future<void> userUpdate() async {
    emit(UserUpdateLoadingState());

    try {
      final userID = CacheHelper.instance!
          .getData(key: "user_id", valueType: ValueType.int);

      print("user ID ::::: $userID");
      print("name ::::: $name");
      print("phone :::::: $phone");
      print("email :::::: $email");
      print("password :::::: $password");

      FormData formData = FormData.fromMap({
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
        if (image != null) "image": await MultipartFile.fromFile(image!.path),
      });

      final response =
          await UserUpdateRepo.updateUser(userID: userID, formData: formData);

      response.when(
          success: (success) {
            userModel = success;
            emit(UserUpdateSuccessState());
          },
          failure: (failure) =>
              emit(UserUpdateErrorState(failure.apiErrorModel.message!)));
    } catch (e) {
      print("Owner Details catch error :::::::::::::: ${e.toString()}");
      emit(UserUpdateErrorState(e.toString()));
    }
  }
}
