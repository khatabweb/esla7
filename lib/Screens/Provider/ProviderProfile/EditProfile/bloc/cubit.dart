import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';
import 'state.dart';

class OwnerUpdateCubit extends Cubit<OwnerUpdateState>{
  OwnerUpdateCubit() : super(OwnerUpdateInitState());

  static OwnerUpdateCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? name;
  String? phone;
  String? email;
  String? minSalary;
  String? commercial;
  String? from;
  String? to;
  String? bankName;
  String? bankAccountOwner;
  String? accountNumber;
  String? password;
  XFile? image;
  XFile? ownerImage;
  OwnerUpdateModel ownerModel = OwnerUpdateModel();


  Future<void> ownerUpdate() async {
    emit(OwnerUpdateLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final token = _pref.getString("owner_token");
      final ownerID = _pref.getInt("owner_id");

      print("user ID ::::: $ownerID");
      print("name ::::: $name");
      print("phone :::::: $phone");
      print("email :::::: $email");
      print("min salary :::::: $minSalary");
      print("commercial :::::: $commercial");
      print("from :::::: $from");
      print("to :::::: $to");
      print("bank name :::::: $bankName");
      print("bank account owner :::::: $bankAccountOwner");
      print("account number :::::: $accountNumber");
      print("password :::::: $password");

      dio.options.headers = {
        "Authorization" : "Bearer $token",
      };

      FormData formData = FormData.fromMap({
        "name" : name,
        "phone" : phone,
        "email" : email,
        "min_salary" : minSalary,
        "commerical" : commercial,
        "from" : from,
        "to" : to,
        "bank_name" : bankName,
        "bank_account_owner" : bankAccountOwner,
        "account_number" : accountNumber,
        "password" : password,
        if(image!=null)
          "image" : await MultipartFile.fromFile(image!.path),
        if(ownerImage!=null)
          "image_owner" : await MultipartFile.fromFile(ownerImage!.path),
      });

      final Response response = await dio.post("${ApiUtl.owner_update_profile}$ownerID", data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        ownerModel = OwnerUpdateModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(OwnerUpdateSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: Owner Details error ::::::::::::::");
        emit(OwnerUpdateErrorState(response.data["message"]));
      }
    }catch(e){
      print("Owner Details catch error :::::::::::::: ${e.toString()}");
      emit(OwnerUpdateErrorState(e.toString()));
    }
  }
}