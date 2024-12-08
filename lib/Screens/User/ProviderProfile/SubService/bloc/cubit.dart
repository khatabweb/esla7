import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../API/api_utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';
import 'state.dart';


/// the same cubit and request in "lib\Screens\Provider\Provider_Services"
class UserSubListCubit extends Cubit<UserSubListState>{
  UserSubListCubit() : super(UserSubListInitState());

  static UserSubListCubit get(context) => BlocProvider.of(context);
  Dio dio = Dio();
  int? ownerId;
  SubListModel subListModel = SubListModel();

  Future<void> userSubService() async {
    emit(UserSubListLoadingState());

    try{
      print("Owner ID: $ownerId");

      FormData formData = FormData.fromMap({
        "owner_id" : ownerId,
      });

      final Response response = await dio.post(ApiUtl.user_sub_service, data: formData);

      if(response.statusCode == 200 && response.data["status"] == "success"){
        print(response.data);
        subListModel = SubListModel.fromJson(response.data);
        print("::::::::::: successsssssssssssssssss ::::::::::::::");
        emit(UserSubListSuccessState());
      }else if(response.statusCode == 200 && response.data["status"] != "success"){
        print("::::::::::: owner service error ::::::::::::::");
        emit(UserSubListErrorState(response.data["message"]));
      }
    }catch(e){
      print("owner service catch error ::::::::::::::${e.toString()}");
      emit(UserSubListErrorState(e.toString()));
    }
  }
}