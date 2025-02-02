import 'package:dio/dio.dart';
import '../repo/checkout_repo.dart';
import '../../../../../core/local_storge/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitState());

  static CheckoutCubit get(context) => BlocProvider.of(context);

  String? bankName, number, senderName, note;
  XFile? image;

  Future<void> checkout(String? ownerName, int? totalPrice) async {
    emit(CheckoutLoadingState());

    try {
      final userName = CacheHelper.instance!
          .getData(key: "user_id", valueType: ValueType.int);

      FormData formData = FormData.fromMap({
        "user_id":
            userName.toString(), //("user_id" == "userName") string not int
        "sender_id":
            ownerName.toString(), //("sender_id" == "ownerName") string not int
        "bank_name": bankName,
        "account_number": number,
        "sender_name": senderName,
        "notes": note,
        "total": totalPrice,
        if (image != null) "image": await MultipartFile.fromFile(image!.path),
      });

      print(formData.fields);

      final response = await CheckoutRepo.checkout(formData: formData);
      response.when(
        success: (data) {
          print("Checkout success ::::::::::::::");
          emit(CheckoutSuccessState());
        },
        failure: (error) {
          print("Checkout error :::::::::::::: ${error.toString()}");
          emit(CheckoutErrorState(error.toString()));
        },
      );
    } catch (e) {
      print("Checkout catch error :::::::::::::: ${e.toString()}");
      emit(CheckoutErrorState(e.toString()));
    }
  }
}
