import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:esla7/API/api_utility.dart';
import 'package:esla7/Screens/CommonScreen/DrawerPages/Views/Complaints_and_suggestions/Bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintsCubit extends Cubit<ComplaintsState>{
  ComplaintsCubit() : super(ComplaintsInitState());

  static ComplaintsCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  String? type, name, phone, message;
  int? orderID;
  XFile? image;

  Future<void> sendComplaints() async {
    emit(ComplaintsLoadingState());

    try{
      final SharedPreferences _pref = await SharedPreferences.getInstance();

      print("type: $type");
      print("name: $name");
      print("phone: $phone");
      print("message: $message");
      print("orderID: $orderID");

      FormData formData = FormData.fromMap({
        "type" : type,
        "name" : name,
        "phone" : "966$phone",
        "order_id" : orderID,
        "message" : message,
        if(image!=null)
          "image" : await MultipartFile.fromFile(image!.path),
      });

      final Response response = await dio.post(ApiUtl.complaints_and_suggestions, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        emit(ComplaintsSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: Sent Complaints state error ::::::::::::::");
        emit(ComplaintsErrorState(response.data["message"]));
      }
    }catch(e){
      print("::::::::::: Sent Complaints catch error ::::::::::::::");
      emit(ComplaintsErrorState(e.toString()));
    }
  }
}