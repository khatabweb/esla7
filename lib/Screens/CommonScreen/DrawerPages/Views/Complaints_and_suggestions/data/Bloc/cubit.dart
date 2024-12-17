import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../repo/complaints_repo.dart';
import 'state.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  ComplaintsCubit() : super(ComplaintsInitState());

  static ComplaintsCubit get(context) => BlocProvider.of(context);
  String? type, name, phone, message;
  int? orderID;
  XFile? image;

  Future<void> sendComplaints() async {
    emit(ComplaintsLoadingState());

    try {
      print("type: $type");
      print("name: $name");
      print("phone: $phone");
      print("message: $message");
      print("orderID: $orderID");

      FormData formData = FormData.fromMap({
        "type": type,
        "name": name,
        "phone": "966$phone",
        "order_id": orderID,
        "message": message,
        if (image != null) "image": await MultipartFile.fromFile(image!.path),
      });

      // final Response response = await dio.post(ApiUtl.complaints_and_suggestions, data: formData);
      final response = await ComplaintsRepo.sendComplaint(formData: formData);

      response.when(
        success: (response) => emit(ComplaintsSuccessState()),
        failure: (error) => emit(
          ComplaintsErrorState(error.apiErrorModel.message!),
        ),
      );
    } catch (e) {
      print("::::::::::: Sent Complaints catch error ::::::::::::::");
      emit(ComplaintsErrorState(e.toString()));
    }
  }
}
