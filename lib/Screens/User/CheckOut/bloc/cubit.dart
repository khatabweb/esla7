import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state.dart';

class CheckoutCubit extends Cubit<CheckoutState>{
  CheckoutCubit() : super(CheckoutInitState());

  static CheckoutCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? bankName, number, senderName, note;
  XFile? image;

  Future<void> checkout(String? ownerName, int? totalPrice) async {
    emit(CheckoutLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      final userName = _pref.getString("user_name");

      FormData formData = FormData.fromMap({
        "user_id" : userName, //("user_id" == "userName") string not int
        "sender_id" : ownerName, //("sender_id" == "ownerName") string not int
        "bank_name" : bankName,
        "number" : number,
        "sender_name" : senderName,
        "notes" : note,
        "total" : totalPrice,
        if(image!=null)
          "image" : await MultipartFile.fromFile(image!.path),
      });

      print(formData.fields);

      final Response response = await dio.post(ApiUtl.user_checkout, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(CheckoutSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: Checkout error ::::::::::::::");
        emit(CheckoutErrorState(response.data["message"]));
      }
    }catch(e){
      print("Checkout catch error :::::::::::::: ${e.toString()}");
      emit(CheckoutErrorState(e.toString()));
    }
  }
}