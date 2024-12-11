import 'package:dio/dio.dart';
import '../../../../../../API/api_utility.dart';
import 'state.dart';
import '../../../../../Widgets/helper/network_screvies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
      final Response response = await NetworkHelper().request(
          ApiUtl.complaints_and_suggestions,
          method: ServerMethods.POST,
          body: formData);
      ;

      if (response.statusCode == 200 && response.data["status"] == "success") {
        print(response.data);
        emit(ComplaintsSuccessState());
      } else if (response.statusCode == 200 &&
          response.data["status"] != "success") {
        print("::::::::::: Sent Complaints state error ::::::::::::::");
        emit(ComplaintsErrorState(response.data["message"]));
      }
    } catch (e) {
      print("::::::::::: Sent Complaints catch error ::::::::::::::");
      emit(ComplaintsErrorState(e.toString()));
    }
  }
}
