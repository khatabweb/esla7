import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../Widgets/helper/cache_helper.dart';
import '../repo/owner_sign_up_repo.dart';
import 'state.dart';

class OwnerSignUpCubit extends Cubit<OwnerSignUpState> {
  OwnerSignUpCubit() : super(OwnerSignUpInitState());

  static OwnerSignUpCubit get(context) => BlocProvider.of(context);

  GetStorage box = GetStorage();
  String? phone;
  String? name;
  String? email;
  int? serviceId;
  String? password;
  String? confirmPassword;
  int? cityId;
  String? address;
  String? minSalary;
  String? commercial;
  XFile? image;
  String? from;
  String? to;
  String? bankAccountOwner;
  String? bankName;
  String? accountNumber;
  String? code;

  Future<void> ownerSignUp() async {
    emit(OwnerSignUpLoadingState());

    try {
      final googleToken = CacheHelper.instance!
          .getData(key: "owner_google_token", valueType: ValueType.string);

      print("phone: $phone");
      print("name: $name");
      print("email: $email");
      print("service Id: $serviceId");
      print("password: $password");
      print("confirm password: $confirmPassword");
      print("city Id: $cityId");
      print("address: $address");
      print("min salary: $minSalary");
      print("commercial num: $commercial");
      print("image name: ${image!.name}");
      print("available from: $from");
      print("available to: $to");
      print("bank account owner: $bankAccountOwner");
      print("bank name: $bankName");
      print("account number: $accountNumber");
      print("google Token: $googleToken");

      FormData formData = FormData.fromMap({
        "phone": "966$phone",
        "name": name,
        "email": email,
        "service_id": serviceId,
        "password": password,
        "confirm_password": confirmPassword,
        "city_id": cityId,
        "address": address,
        "min_salary": minSalary,
        "commerical": commercial,
        "image_owner": await MultipartFile.fromFile(image!.path),
        "from": from,
        "to": to,
        "bank_account_owner": bankAccountOwner,
        "bank_name": bankName,
        "account_number": accountNumber,
        "google_token": googleToken,
      });

      final response = await OwnerSignUpRepo.signUp(
        formData: formData,
      );
      response.when(success: (data) {
        CacheHelper.instance!
            .setData("owner_token", value: data["access_token"]);
        CacheHelper.instance!.setData("owner_id", value: data["owner_id"]);
        box.write("id", data["owner_id"]);
        CacheHelper.instance!.setData("type", value: data["type"]);
        print(data);
        code = data["code"].toString();
        emit(OwnerSignUpSuccessState());
      }, failure: (error) {
        emit(OwnerSignUpErrorState(error.apiErrorModel.message!));
        upDate();
      });
    } catch (e) {
      print("SignUp catch error ::::::::::::::${e.toString()}");
      emit(OwnerSignUpErrorState(e.toString()));
    }
  }

  void upDate() => emit(OwnerSignUpInitState());
}
