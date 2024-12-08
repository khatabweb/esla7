import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../model/model.dart';
import '../repo/owner_update_repo.dart';
import 'state.dart';

class OwnerUpdateCubit extends Cubit<OwnerUpdateState> {
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

    try {
      FormData formData = FormData.fromMap({
        "name": name,
        "phone": phone,
        "email": email,
        "min_salary": minSalary,
        "commerical": commercial,
        "from": from,
        "to": to,
        "bank_name": bankName,
        "bank_account_owner": bankAccountOwner,
        "account_number": accountNumber,
        "password": password,
        if (image != null) "image": await MultipartFile.fromFile(image!.path),
        if (ownerImage != null)
          "image_owner": await MultipartFile.fromFile(ownerImage!.path),
      });

      final response = await OwnerUpdateRepo.ownerUpdate(formData: formData);
      response.when(success: (response) {
        ownerModel = response;
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(OwnerUpdateSuccessState());
      }, failure: (error) {
        print("::::::::::: Owner Details error ::::::::::::::");
        emit(OwnerUpdateErrorState(error.apiErrorModel.message!));
      });
    } catch (e) {
      print("Owner Details catch error :::::::::::::: ${e.toString()}");
      emit(OwnerUpdateErrorState(e.toString()));
    }
  }
}
