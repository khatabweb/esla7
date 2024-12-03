import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/Provider/Auth/SignUp/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerSignUpCubit extends Cubit<OwnerSignUpState>{
  OwnerSignUpCubit() : super(OwnerSignUpInitState());

  static OwnerSignUpCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  GetStorage box =GetStorage();
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

  Future<void> ownerSignUp() async {
    emit(OwnerSignUpLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final googleToken = _pref.getString("owner_google_token");

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
        "phone" : "966$phone",
        "name" : name,
        "email" : email,
        "service_id" : serviceId,
        "password" : password,
        "confirm_password" : confirmPassword,
        "city_id" : cityId,
        "address" : address,
        "min_salary" : minSalary,
        "commerical" : commercial,
        "image_owner" : await MultipartFile.fromFile(image!.path),
        "from" : from,
        "to" : to,
        "bank_account_owner" : bankAccountOwner,
        "bank_name" : bankName,
        "account_number" : accountNumber,
        "google_token" : googleToken,
      });

      final Response response = await dio.post(ApiUtl.owner_register, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        _pref.setString("owner_token", response.data["access_token"]);
        _pref.setInt("owner_id", response.data["owner_id"]);
        box.write("id", response.data["owner_id"]);
        _pref.setString("type", response.data["type"]);
        print(response.data);
        emit(OwnerSignUpSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: User Sign up error ::::::::::::::");
        emit(OwnerSignUpErrorState(response.data["message"]));
      }

    }catch(e){
      print("SignUp catch error ::::::::::::::${e.toString()}");
      emit(OwnerSignUpErrorState(e.toString()));
    }
  }
}